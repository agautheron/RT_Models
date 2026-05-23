import numpy

def read_LCMRAW(path):
    header = {}
    data = []
    with open(path) as f:
        # Read header
        end_count = 0
        while end_count<2:
            line = f.readline().strip()
            if line.startswith("$END"):
                end_count += 1
            elif "=" in line:
                if line.startswith("$"):
                    key, value = line[1:].split("=")
                else:
                    key, value = line.split("=")
                header[key.strip()] = value.strip()
        
        # Read data
        for line in f:
            if line.strip() == "":
                continue
            data.append(float(line))

    # Convert to numpy array
    data = numpy.array(data)

    # Recombine interleaved real and imaginary parts
    real = data[0::2]
    imaginary = data[1::2]
    signal = real + 1j * imaginary
    
    # NOTE: conjugate here to avoid explicit conjugation in each FT
    return header, signal.conj()

def fft_signal(signal):
    return numpy.fft.fftshift(numpy.fft.fft(signal))
