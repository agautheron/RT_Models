MR Spectroscopy
===============

*Section authors:* Helene Ratiney <helene.ratiney@creatis.insa-lyon.fr>, Angeline Nemeth <angeline.nemeth@universite-paris-saclay.fr>


MR signal/spectrum display
--------------------------

The aim of this project is to get you to manipulate spectra and learn the first reflexes for displaying and quantifying spectra.

Change the name of the signal, spectrum and header each time you read a signal (for example sig1, ft1, header1, then sig2, ft2, header2, etc... ). *
Also, when using the solution code, change the path to your working directory accordingly.

1. Load the Creatine signal from `<Cr.RAW>`__ using `<read_LCMRAW.m>`__ or `<utils.py>`__ and display it in time and frequency domain (x-axis in points) 

    .. solution::
        
        .. tab:: Python
            
            .. literalinclude:: spectroscopy.py
                :lines: 1-25
        
        .. tab:: MATLAB
            
            .. literalinclude:: spectroscopy.m
                :lines: 2-27	
        
        .. image:: Cr_no_dwell_time.png
        
        Note: the FFT used in Python and MATLAB returns data where the frequency 0 is the first item in the array, and the extremal frequencies are in the middle of an array. To recover the spectrum in the "usual" way (i.e. zero frequency in the middle), the `fftshift` function must be used. In Python, this whole behavior is already provided by the `utils.fft_signal` function; in MATLAB, you must define it as
        
        .. code:: MATLAB
            
            function result = fft_signal(signal)
                result = fftshift(fft(signal, [], 2));
            end


2. The sampling time or dwell time for this signal was dt = 0.4 ms. Compute the sampling frequency and the frequency axis in Hz. Display the spectrum with the time axis in s and the frequency axis in Hz. 

    .. solution::
        
        .. tab:: Python
        
            .. literalinclude:: spectroscopy.py
                :lines: 27-48
                
        .. tab:: MATLAB
        
            .. literalinclude:: spectroscopy.m
                :lines: 30-56
        
        .. image:: Cr.png

3. Measure the distance between the two peaks.
    
    .. solution::
        .. tab:: Python
            
            .. literalinclude:: spectroscopy.py
                :lines: 52-56
                
        The frequency shift between the two peaks is around 109 Hz. 
			
4. Now, load the Creatine signal from `<Cr3.RAW>`__ and do the same as before but using dt=0.183 ms.
    
    .. solution::
        
        .. tab:: Python
        
            .. literalinclude:: spectroscopy.py
                :lines: 58-80
                
        .. tab:: MATLAB
        
            .. literalinclude:: spectroscopy.m
                :lines: 58-93
        
        .. image:: Cr3.png

5. Measure again the distance between the two peaks.
    
    .. solution::
        .. tab:: Python
            
            .. literalinclude:: spectroscopy.py
                :lines: 84-88
              
        The frequency shift between the two peaks is around 443 Hz.
    
6. Knowing that in the first case, the spectrum was acquired at 2.89 T, can you deduce at which field the second one was acquired?

    .. solution::
        .. tab:: Python
            
            .. literalinclude:: spectroscopy.py
                :lines: 90
        
        11.78 T

7. An other way to display spectrum is to use ppm axis instead of Hz axis. As a reminder, the definition of ppm is : $\delta = (\nu_0 - \nu_{0 ref})/\nu_{0 ref}$
Here, in the case of in vivo acquisition, the frequency $\nu_{0 ref}$ referes to the main carrier frequency present in biological tissues (the water). Normally, the water peak is located at 4.7 ppm.  The frequency $\nu_{0 ref}$ is saved in the header of the raw data (parameter "HZPPM", 500.3 in `Cr3.RAW`). 
Now, display the two spectra in ppm (shift the spectra by 4.7 ppm, and scale them by their maximum). 

    .. solution::
        
        .. tab:: Python
            
            .. literalinclude:: spectroscopy.py
                :lines: 92-111
        
        .. tab:: MATLAB
            
            .. literalinclude:: spectroscopy.m
                :lines: 95-112
        
        .. image:: ppm.png

8. At this step, we are going to work with on other metabolite present in the brain: the lactate. Load the file `<Lac.RAW>`__.
Display the spectrum, and identify the chemical shifts and multiplet based on `published values <https://doi.org/10.1002/1099-1492(200005)13:3%3C129::aid-nbm619%3E3.0.co;2-v>`_
    
    +-------+--------------------+--------------------+--------------+--------+
    | Group | Shift (ppm) in H2O | Shift (ppm) in D2O | Multiplicity | J (Hz) |
    +=======+====================+====================+==============+========+
    | 2 CH  |             4.0974 |             4.0908 |            q |  6.933 |
    +-------+--------------------+--------------------+--------------+--------+
    | 3 CH3 |             1.3142 |             1.3125 |            d |        |
    +-------+--------------------+--------------------+--------------+--------+

    .. solution::

        .. tab:: Python

            .. literalinclude:: spectroscopy.py
                :lines: 115-131

        .. tab:: MATLAB

            .. literalinclude:: spectroscopy.m
                :lines: 114-137

Apodization
-----------
Stopping signal sampling before complete decay leads to truncation artifacts. One way to attenuate these artifacts is to apodize the signal by multiplying the temporal signal using an apodization function ( i.e multiplication with an exponential decay term.)

a) Apodize the Creatine signal (Cr.RAW)  with a damping factor of 5 Hz.

.. solution::

    .. tab:: Python

        .. literalinclude:: spectroscopy.py
            :lines: 136-138

    .. tab:: MATLAB

        .. literalinclude:: spectroscopy.m
            :lines: 140-144

b) Compare the two temporal signals (with and without apodization) and their spectra.

.. solution::

    .. tab:: Python

        .. literalinclude:: spectroscopy.py
            :lines: 141-151

    .. tab:: MATLAB

        .. literalinclude:: spectroscopy.m
            :lines: 146-159
    
    .. image:: apodization.png

Frequency shift
---------------
Shifting the spectrum by a few Hz is useful to register different acquisition or to fit a model to an acquired spectrum. The frequency shift by $\delta f$ of a spectrum corresponds to a multiplication in the time domain by $exp(i\ 2\pi\ \delta f)$

.. solution::

    .. tab:: Python

        .. literalinclude:: spectroscopy.py
            :lines: 156-168
    
    .. tab:: MATLAB

        .. literalinclude:: spectroscopy.m
            :lines: 163-173
    
    .. image:: frequency_shift.png

Zero-order Phase
----------------
Sometimes, the acquired signal/spectrum is affected by a zero order phase. This corresponds to a multiplication of the signal with a fixed phase term $exp(i\ \phi_{0})$, to see the effect of this term on the spectrum,
apply it to the Creatine signal and display the spectrum (the term can be multiplied either in the time domain
or in the frequency domain). Choose $\phi_{0}$ above 30°, remember that $\phi_0$ is expressed in rad.

.. solution::

    .. tab:: Python

        .. literalinclude:: spectroscopy.py
            :lines: 172-184

    .. tab:: MATLAB

        .. literalinclude:: spectroscopy.m
            :lines: 189-199
    
    .. image:: rephase.png
