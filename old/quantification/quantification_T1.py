import matplotlib.pyplot
import numpy
import scipy

## Define and visualize bi-exponential model

# Define species
M0a = 1
M0b = 0.1
R = 15 # s-1
T1a = 1.1 # s
T1b = 0.2 # s

Kab = R*M0b
Kba = R*M0a
R1a = 1/T1a # s-1
R1b = 1/T1b # s-1

# Define model
A = numpy.array([
    [-(R1a + Kab),        Kba],
    [        Kab, -(R1b + Kba)]])

ANoExch = numpy.array([
    [-R1a,    0],
    [   0, -R1b]])

B = numpy.array([R1a*M0a, R1b*M0b])

# relaxation and exchange during time step
step = 0.005 # s
A_exp = scipy.linalg.expm(A*step)
AB_cst = scipy.linalg.inv(A) @ (A_exp-numpy.identity(2)) @ B

# relaxation only during time_inc
ANoExch_exp = scipy.linalg.expm(ANoExch*step)
ABNoExch_cst = scipy.linalg.inv(ANoExch) @ (ANoExch_exp-numpy.identity(2)) @ B

# initialize
time_max = 5
time_1D = numpy.arange(0, time_max+step, step)
Np = len(time_1D)

Mdata = numpy.zeros((2, Np))
MdataNoExch = numpy.zeros((2, Np))

Ma_ini = -M0a
Mb_ini = 0.9*M0b

Mini = numpy.array([Ma_ini, Mb_ini])
Mdata[:,0] = Mini
MdataNoExch[:,0] = Mini

# Simulate over time
for i in range(1, Np):
    Mdata[:,i] = A_exp @ Mdata[:, i-1] + AB_cst
    MdataNoExch[:,i] = ANoExch_exp @ MdataNoExch[:, i-1] + ABNoExch_cst

# Plot results
figure, plots = matplotlib.pyplot.subplots(
    1, 2, sharex=True, sharey=True, layout="tight", figsize=(8,4))
plots[0].plot(time_1D, Mdata[0, :], "b", label="$M_a$")
plots[0].plot(time_1D, Mdata[1, :], "r", label="$M_b$")
plots[0].plot(time_1D, MdataNoExch[0, :], "b--", label="$M_a$ (no exch.)")
plots[0].plot(time_1D, MdataNoExch[1, :], "r--", label="$M_b$ (no exch.)")
plots[0].set(xlabel="Time (s)", ylabel="Magnetization (a.u.)")
plots[0].legend()

plots[1].plot(time_1D, Mdata[0,:]/M0a, "b", label="$M_a/M0_a$")
plots[1].plot(time_1D, Mdata[1, :]/M0b, "r", label="$M_b/M0_b$")
plots[1].set(xlabel="Time (s)")
plots[1].legend()

figure.suptitle(
    f"Input: $T_1^a$ = {1000/R1a:.0f} ms, $T_1^b$ = {1000/R1b:.0f} ms, "
    f"R = {R} s$^{{-1}}$")

figure.savefig("quantification/quantification_T1_BM.png")

## Make noisy signal

# intravoxel averaging, second pool not detectable - short T2b
signal = Mdata[0, :]/M0a

# intravoxel averaging, both pools are detectable, neglect T2w
# signal = Mdata.sum(axis=0)

# set noise properties
noise_mean = 0
noise_sd = 0.01

# calculate signal
signal_meas = signal + numpy.random.normal(noise_mean, noise_sd, signal.shape)

# plot results
figure, plot = matplotlib.pyplot.subplots(layout="tight", figsize=(5, 4))
plot.plot(time_1D, signal_meas, "k")
plot.set(xlabel="Time (s)", ylabel="Signal (a.u.)")

figure.savefig("quantification/quantification_T1_BM_noisy.png")

## Simulate data with known analytical solution

R1_short = (R1a + R1b + Kab + Kba + numpy.sqrt((R1a - R1b + Kab - Kba)**2 + 4*Kab*Kba))/2
R1_long = (R1a + R1b + Kab + Kba - numpy.sqrt((R1a - R1b + Kab - Kba)**2 + 4*Kab*Kba))/2
b_short = ((Ma_ini/M0a - 1)*(R1a - R1_long) + (Ma_ini/M0a - Mb_ini/M0b)*Kab)/(R1_short-R1_long)
b_long = -((Ma_ini/M0a - 1)*(R1a - R1_short) + (Ma_ini/M0a - Mb_ini/M0b)*Kab)/(R1_short-R1_long)

signal_simulated = 1 + b_short*numpy.exp(-R1_short*time_1D) + b_long*numpy.exp(-R1_long*time_1D)

print("Theoretical parameters:")
print(f"  - b_short = {b_short:.3f}")
print(f"  - T1_short = {1000/R1_short:.3f} ms")
print(f"  - b_long = {b_long:.3f}")
print(f"  - T1_long = {1000/R1_long:.3f} ms")

Rex_pure = Kab + Kba
print(f"  - T1ex_pure = {1000/Rex_pure:.3f} ms")

##  Fit the data

# define fitting function
def F(time, b_short, R1_short, b_long, R1_long):
    return (1+ b_short*numpy.exp(-R1_short*time)) + b_long*numpy.exp(-R1_long*time)

# set intitial guess
x0 = [b_short, R1_short, b_long, R1_long]

# set lower and upper boundaries 
lb = [-10, 0, -10, 0] 
ub = [10, 1e6, 10, 1e6]

# perform fitting
x, covariance = scipy.optimize.curve_fit(F, time_1D, signal_meas, x0, bounds=(lb, ub))

# calculate standard deviation from the covariance matrix of the last fit
Sd_fromfit = numpy.sqrt(numpy.diag(covariance))

if x[3] > x[1]:
    # Swap short and long parameters
    x[0], x[2] = x[2], x[0]
    x[1], x[3] = x[3], x[1]

bs_est = x[0]
T1s_est_ms = 1000/x[1]
bl_est = x[2]
T1l_est_ms = 1000/x[3]

# plot results
figure, plot = matplotlib.pyplot.subplots(layout="tight", figsize=(5, 4))
plot.plot(time_1D, F(time_1D, *x), "r", label="Fit")
plot.plot(time_1D, signal_simulated, "k--", label="Simulated")
figure.suptitle(f"Est. $T_1^S$ = {T1s_est_ms:.0f} ms, $T_1^L$ = {T1l_est_ms:.0f} ms")
plot.legend()

figure.savefig("quantification/quantification_T1_fit.png")

print("Fitted parameters:")
print(f"  - b_short = {bs_est:.3f} ± {Sd_fromfit[0]:.3f}")
print(f"  - T1_short = {T1s_est_ms:.3f} ± {1000*Sd_fromfit[1]/(x[1]**2):.3f} ms")
print(f"  - b_long = {bl_est:.3f} ± {Sd_fromfit[2]:.3f}")
print(f"  - T1_long = {T1l_est_ms:.3f} ± {1000*Sd_fromfit[3]/(x[3]**2):.3f} ms")

## Monte Carlo

# set number of trials
Nbet = 300

# initilize variable storage
T1s_1D = numpy.zeros(Nbet)
Bs_1D = numpy.zeros(Nbet)
T1l_1D = numpy.zeros(Nbet)
Bl_1D = numpy.zeros(Nbet)

for i in range(Nbet):
    # calculate signal
    signal_meas = signal + numpy.random.normal(noise_mean, noise_sd, len(signal))
    
    # perform fitting
    x, _ = scipy.optimize.curve_fit(F, time_1D, signal_meas, x0, bounds=(lb, ub))
    
    # store results
    Bs_1D[i] = x[0]
    T1s_1D[i] = 1/x[1]
    Bl_1D[i] = x[2]
    T1l_1D[i] = 1/x[3]

# compute statistics over the Nbet trials

bs_mean = numpy.mean(Bs_1D)
bs_std = numpy.std(Bs_1D)

T1s_mean_ms = 1000*numpy.mean(T1s_1D)
T1s_std_ms = 1000*numpy.std(T1s_1D)

bl_mean = numpy.mean(Bl_1D)
bl_std = numpy.std(Bl_1D)

T1l_mean_ms = 1000*numpy.mean(T1l_1D)
T1l_std_ms = 1000*numpy.std(T1l_1D)

print("Monte Carlo parameters")
print(f"  - b_short = {bs_mean:.3f} ± {bs_std:.3f}")
print(f"  - T1_short = {T1s_mean_ms:.3f} ± {T1s_std_ms:.3f} ms")
print(f"  - b_long = {bl_mean:.3f} ± {bl_std:.3f}")
print(f"  - T1_long = {T1l_mean_ms:.3f} ± {T1l_std_ms:.3f}  ms")

## display results
Nbins = 30
figure, plots = matplotlib.pyplot.subplots(2, 2, layout="tight", figsize=(8,8))

plots[0,0].hist(T1s_1D, Nbins, label=f"$T_1^s$={T1s_mean_ms:.0f} ± {T1s_std_ms:.3f} ms")
plots[0,0].set(xlabel="$T_1^s$ (s)", yticks=[])

plots[1,0].hist(Bs_1D, Nbins, label=f"$b^s$={bs_mean:.3f} ± {bs_std:.3f}")
plots[1,0].set(xlabel="$b^s$ (a.u.)", yticks=[])

plots[0,1].hist(T1l_1D, Nbins, label=f"$T_1^l$={T1l_mean_ms:.0f} ± {T1l_std_ms:.3f} ms")
plots[0,1].set(xlabel="$T_1^l$ (s)", yticks=[])

plots[1,1].hist(Bl_1D, Nbins, label=f"$b^l$={bl_mean:.3f} ± {bl_std:.3f}")
plots[1,1].set(xlabel="$b^l$ (a.u.)", yticks=[])

for plot in plots.ravel():
    plot.legend()
    plot.spines[["left", "top", "right"]].set_visible(False)

figure.savefig("quantification/quantification_T1_monte_carlo.png")
