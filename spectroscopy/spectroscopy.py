import numpy
import matplotlib.pyplot
import scipy

import utils

# Read the signal written in Cr.Raw
header_1, signal_1 = utils.read_LCMRAW("Cr.RAW")

# Plot time domain and Frequency Domain, with sample number as x-axis
figure, plots = matplotlib.pyplot.subplots(2, 1, layout="constrained")
plots[0].plot(signal_1.real)
plots[0].set_title("Signal - Real Part")
plots[0].set_xlabel("Sample number (unitless)")
plots[0].set_ylabel("Amplitude (arbitrary unit)")
plots[0].grid(True)

ft_1 = utils.fft_signal(signal_1)
plots[1].plot(ft_1.real)
plots[1].set_title("Spectrum - Real Part")
plots[1].set_xlabel("Frequency (1/sample number)")
plots[1].set_ylabel("Amplitude (arbitrary unit)")
plots[1].grid(True)

figure.savefig("Cr_no_dwell_time.png")

# The sampling time (also called dwell time) is 0.4 ms.
# Display the signal with x-axis in s for time domain, x-axis in Hz for
# frequency domain representation
dt = 0.0004
# Compute time axis in s
time_1 = numpy.arange(0, dt * len(signal_1), dt)
# Compute frequency axis in Hz
frequency_1 = numpy.fft.fftshift(numpy.fft.fftfreq(len(signal_1), dt))
# Display
figure, plots = matplotlib.pyplot.subplots(2, 1, layout="constrained")

plots[0].plot(time_1, signal_1.real)
plots[0].set_title("Signal - Real Part")
plots[0].set_xlabel("Time (s)")
plots[0].set_ylabel("Amplitude (arbitrary unit)")
plots[0].grid(True)

plots[1].plot(frequency_1, ft_1.real)
plots[1].set_title("Spectrum - Real Part")
plots[1].set_xlabel("Frequency (Hz)")
plots[1].set_ylabel("Amplitude (arbitrary unit)")
plots[1].grid(True)

figure.savefig("Cr.png")

# Compute the peaks above 100 (arbitrary units)
peaks_1, heights = scipy.signal.find_peaks(ft_1.real, 100)
peaks_frequencies_1 = frequency_1[peaks_1]
peak_distance_1 = peaks_frequencies_1[1]-peaks_frequencies_1[0]
print("Distance betweek peaks:", int(numpy.round(peak_distance_1)), "Hz")

# Read the signal written in Cr3.RAW
header_2, signal_2 = utils.read_LCMRAW("Cr3.RAW")
ft_2 = utils.fft_signal(signal_2)

dt = 0.000183
# Compute frequency axis in Hz
frequency_2 = numpy.fft.fftshift(numpy.fft.fftfreq(len(signal_2), dt))
# Compute time axis in s
time_2 = numpy.arange(0, dt * len(signal_2), dt)
# Display
figure, plots = matplotlib.pyplot.subplots(2, 1, layout="constrained")

plots[0].plot(time_2, signal_2.real)
plots[0].set_title("Signal - Real Part")
plots[0].set_xlabel("Time (s)")
plots[0].set_ylabel("Amplitude (arbitrary unit)")
plots[0].grid(True)

plots[1].plot(frequency_2, ft_2.real)
plots[1].set_title("Spectrum - Real Part")
plots[1].set_xlabel("Frequency (Hz)")
plots[1].set_ylabel("Amplitude (arbitrary unit)")
plots[1].grid(True)

figure.savefig("Cr3.png")

# Compute the peaks above 100 (arbitrary units)
peaks_2, heights = scipy.signal.find_peaks(ft_2.real, 1)
peaks_frequencies_2 = frequency_2[peaks_2]
peak_distance_2 = peaks_frequencies_2[1]-peaks_frequencies_2[0]
print("Distance betweek peaks:", int(numpy.round(peak_distance_2)), "Hz")

print("Estimated field for Cr3", 2.89*peak_distance_2/peak_distance_1, "T")

# Now display the spectrum with the ppm convention (you will need to retrieve
# the carrier frequency from the header)
# Dispplay in  ppm
figure, plot = matplotlib.pyplot.subplots(layout="constrained")

carrier_frequency_1 = float(header_1["HZPPM"])
ppm_1 = frequency_1/carrier_frequency_1 + 4.7
plot.plot(
    ppm_1, ft_1.real/ft_1.real.max(),
    c="C0", lw=1, label="$B_0 \\approx$ 3 T")

carrier_frequency_2 = float(header_2["HZPPM"])
ppm_2 = frequency_2/carrier_frequency_2 + 4.7
plot.plot(
    ppm_2, ft_2.real/ft_2.real.max(),
    c="C1", lw=1, label="$B_0 \\approx$ 11.7 T")

plot.set(xlim=(0, 5.5), xlabel="Frequency shift (ppm)")
plot.xaxis.set_inverted(True)
plot.legend()

figure.savefig("ppm.png")

# Redo the same thing with the Lac , reteive the ppm value of the different
# chemical groups, measure on the doublet (spectrum in absolutevalue) J-coupling
# value

header_3, signal_3 = utils.read_LCMRAW("Lac.RAW")
ft_3 = utils.fft_signal(signal_3)

dt = 0.0004
frequency_3 = numpy.fft.fftshift(numpy.fft.fftfreq(len(signal_3), dt))
carrier_frequency_3 = float(header_3["HZPPM"])
ppm_3 = frequency_3/carrier_frequency_3 + 4.7

figure, plot = matplotlib.pyplot.subplots(layout="constrained")

plot.plot(ppm_3, ft_3.real, c="black", lw=1)
plot.set(xlim=(0, 5.5), xlabel="Frequency shift (ppm)")
plot.xaxis.set_inverted(True)

figure.savefig("Lac.png")

## Apodization
damping = 20
apodization = numpy.exp(-damping*time_1)
signal_apodized = signal_1 * apodization
ft_apodized = utils.fft_signal(signal_apodized)

figure, plots = matplotlib.pyplot.subplots(2, 1, layout="constrained")
plots[0].plot(time_1, signal_1.real, c="C0", label="Raw signal")
plots[0].plot(time_1, signal_apodized.real, c="C1", label="Apodized signal")
plots[0].set(xlabel="Time (s)", ylabel="Amplitude (arbitrary unit)")
plots[0].legend()
plots[1].plot(ppm_1, ft_1.real, c="C0")
plots[1].plot(ppm_1, ft_apodized.real, c="C1")
plots[1].set(
    xlim=(0, 5.5), xlabel="Frequency shift (ppm)",
    ylabel="Amplitude (arbitrary unit)")
plots[1].xaxis.set_inverted(True)

figure.savefig("apodization.png")

## Frequency shift
delta_f = 10
shift = numpy.exp(1j * 2*numpy.pi * delta_f*time_1)
signal_shifted = signal_1 * shift
ft_shifted = utils.fft_signal(signal_shifted)

figure, plot = matplotlib.pyplot.subplots(1, 1, layout="constrained")
plot.plot(ppm_1, ft_1.real, c="C0", label="Raw spectrum")
plot.plot(ppm_1, ft_shifted.real, c="C1", label="Shifted spectrum")
plot.set(
    xlim=(0, 5.5), xlabel="Frequency shift (ppm)",
    ylabel="Amplitude (arbitrary unit)")
plot.xaxis.set_inverted(True)
plot.legend()
figure.savefig("frequency_shift.png")

## Zero-order phase
phi0 = numpy.radians(50)
rephase = numpy.exp(1j * phi0)
signal_rephased = signal_1 * rephase
ft_rephased = utils.fft_signal(signal_rephased)

figure, plot = matplotlib.pyplot.subplots(1, 1, layout="constrained")
plot.plot(ppm_1, ft_1.real, c="C0", label="Raw spectrum")
plot.plot(ppm_1, ft_rephased.real, c="C1", label="Rephased spectrum")
plot.set(
    xlim=(0, 5.5), xlabel="Frequency shift (ppm)",
    ylabel="Amplitude (arbitrary unit)")
plot.xaxis.set_inverted(True)
plot.legend()
figure.savefig("rephase.png")
