Spatial Encoding
================

*Section authors:* Jean-Marie Bonny <jean-marie.bonny@inrae.fr>, Julien Lamy <lamy@unistra.fr>

One Dimension
-------------

Phantom Object
~~~~~~~~~~~~~~

Create a phantom made of three objects with a radius of 2 cm. The three objects are centered respectively at -5 cm, 0 cm and +5 cm.

.. tab:: Python
    
    .. literalinclude:: spatial_encoding_1d.py
        :lines: 8-9
        :dedent: 4
.. tab:: MATLAB
    
    .. literalinclude:: spatial_encoding_1d.m
        :lines: 1-2
        :language: matlab

Define the geometry of the image: assume the field of view is 15 cm wide, with a voxel size of 1 mm.

.. tab:: Python
    
    .. literalinclude:: spatial_encoding_1d.py
        :lines: 12-18
        :dedent: 4
.. tab:: MATLAB
    
    .. literalinclude:: spatial_encoding_1d.m
        :lines: 4-13
        :language: matlab

Specify the properties (i.e. $M_0$, $T_1$, and $T_2$) of each object. The equilibrium magnetization will decrease from left to right and take values of 1, 0.7, and 0.5. The $T_1$ will have a V-shape with values 1 s, 700 ms, 2 s. The $T_2$ will increase from left to right with values 10 ms, 50 ms, 100 ms.

.. tab:: Python
    
    .. literalinclude:: spatial_encoding_1d.py
        :lines: 19-21
        :dedent: 4
.. tab:: MATLAB
    
    .. literalinclude:: spatial_encoding_1d.m
        :lines: 15-26
        :language: matlab

.. image:: object_1d.png

K-space
~~~~~~~

The voxel size ($\Delta_x$) and the extent of the k-space ($L_k$) are inversely related, and this is also the case for the image extent ($L_x$) and the spacing between adjacent k-space points ($\Delta_k$):

$$
\begin{align*}
L_x &= 2\pi/\Delta k \\
\Delta x &= 2\pi/L_k
\end{align*}
$$

Note that the 2π factor in the preceding equation assumes that the k-space coordinates are expressed in rad/m: depending on the convention used for the gyromagnetic ratio (either as an angular frequency in rad$\cdot$Hz/T or as a temporal frequency in Hz/T), the k-space coordinates can also be expressed in 1/m.

Assuming that the definition of the k-space is the same as that of the physical space, compute the maximum coordinate in the k-space to achieve the required voxel size and the spacing between adjacent k-space points. If the definition of the k-space was half that of the physical space while keeping the same extent, what would be the field of view? What impact would that have on the image? Compute the trajectory through the k-space to sample all points required to achive the required voxel size.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_1d.py
            :lines: 30-33
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 28-31
            :language: matlab
    
    The maximum k-space coordinate is 6283.19 rad/m and the spacing between k-space points is 42.17 rad/m. With a definition half that of the physical space, the spacing between adjacent k-space samples would be 84.34 rad/m, giving a field of view of 7.45 cm ($1/(\Delta k/(2\pi))$). Since the object is wider than this, we would get aliasing in the image.

The k-space is defined as the time integral of the gradient amplitude, and, conversely, the gradient amplitude matching a k-space trajectory is the derivative of the trajectory:

$$\begin{align*}
k(t) &= \gamma \int G(t) \dt \\
G(t) &= \frac{\d k(t)}{\dt}
\end{align*}$$

Assuming that the dwell time (sampling duration of each k-space point) is 10 µs, what is the total readout duration? What is the gradient amplitude?

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_1d.py
            :lines: 37-38
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 33-34
            :language: matlab
    
    The total readout duration is 1.5 ms. Since the k-space location is equal to $\gamma G \tau$ with a constant gradient amplitude, the gradient amplitude can be computed as the derivative of the k-space trajectory scaled by the gyromagnetic ratio and the dwell time. In this case, due to the regular sampling of the k-space, the gradient amplitude is constant, and equal to 15.76 mT/m.
    
    Note that this is an ideal case: on actual scanners, the gradient amplitude takes a short time to vary between zero and its requested amplitude. This rise time creates trapezoidal gradient lobes instead of the ideal rectangular lobes.

Sampling
~~~~~~~~

Create the simulation environment for the phantom, keeping only the objects, and apply a 90° RF pulse to tip the magnetization to the transversal plane.

.. tab:: Python
    
    .. literalinclude:: spatial_encoding_1d.py
        :lines: 103-105
        :dedent: 4
.. tab:: MATLAB
    
    .. literalinclude:: spatial_encoding_1d.m
        :lines: 98-100
        :language: matlab

Proceed to sample the k-space: to do so, you will need to apply gradients to your simulation (``simulator.gradient(amplitude, duration)``) and to compute the total signal, which is defined as the complex sum of the transversal magnetization of all isochromats:

.. tab:: Python
    
    .. code:: python
        
        M = simulator.magnetization[:, 0] + 1j*simulator.magnetization[:, 1]
        signal = M.sum()
.. tab:: MATLAB
    
    .. code:: matlab
        
        M = simulator.magnetization(1, :) + 1j*simulator.magnetization(2, :);
        signal = sum(M);

Describe and explain all gradient lobes used in your simulation. Plot the simulated signal magnitude and discuss.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_1d.py
            :lines: 101-102,109-121
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 96-97,104-118
            :language: matlab
            :dedent: 4
    
    The first gradient lobe moves to the start of the k-space trajectory. In this example, the maximum gradient amplitude of the system is used so that the gradient lobe has the shortest-possible duration in order to minimize the relaxation effects. With the parameters shown in the solution above, the duration of this gradient lobe is 0.47 ms.
    
    In the ``for`` loop, the signal at the i\ :superscript:`th` point is stored in an array, and a gradient is applied to move through the k-space. The amplitude and duration of those gradient lobes are those described above.
    
    .. image:: signal_1d.png
    
    The recorded signal magnitude shows a sharp peak in the center of the k-space: this is due to the fact that the phantom contains more low spatial frequency content than high spatial frequency content.

Reconstruction
~~~~~~~~~~~~~~

The image can be reconstructed from the complex signal with a Fourier transform. Note that most FFT algorithms (`Python <https://numpy.org/doc/stable/reference/generated/numpy.fft.fft.html>`__, `MATLAB <https://mathworks.com/help/matlab/ref/fft.html>`__) will expect the high-frequency content at the *center* of the array, and the low-frequency content at the *edges* of the array. This is not the case in this example, and it is necessary to use the ``fftshift`` function (`Python <https://numpy.org/doc/stable/reference/generated/numpy.fft.fftshift.html>`__, `MATLAB <https://mathworks.com/help/matlab/ref/fftshift.html>`__) to transform the data to and from the centered form.

Compute the reconstruction of the image, plot the magnitude and discuss the results with respect to the values of $M_0$, $T_1$ and $T_2$.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_1d.py
            :lines: 61
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 40
            :language: matlab
    
    .. image:: image_1d.png
    
    The bulk structure of the phantom is recovered, with the correct positions. 
    The contrast between the respective regions depends mostly on the $M_0$ values: since the readout is performed immediately after the RF and the readout duration is short, almost no relaxation happened and the image is neither $T_1$-weighted nor $T_2$-weighted.
    
    The ripples present in the three objects are called Gibbs ringing, or truncation artifact. They are caused by a sharp transition from background to object coupled with a partial sampling of the frequency spectrum.

Effect of Relaxation
~~~~~~~~~~~~~~~~~~~~

Delay the start of the trajectory (``simulator.idle(20e-3)`` between the pulse and the start of the read-out), and plot the image. Discuss the differences.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_1d.py
            :lines: 58,102-121
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 50
            :language: matlab
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 97-118
            :dedent: 4
            :language: matlab
    
    .. image:: image_1d_T2.png
    
    With a longer echo time, the contrast between the objects is very different: even though the $M_0$ of the left-most object is high, it has a short $T_2$ of 10 ms so that the signal has decayed at the echo time. The middle and right-most objects have longer $T_2$ values, but those still play a role in the contrast: the intensity difference between the two objects is much lower than in the previous case.
    
    Since this experiment only has a single RF pulse, no $T_1$ contrast can be obtained: we need at least two RF pulses to generate a $T_1$ contrast, with the first one creating recovering longitudinal magnetization, and the second one tipping this magnetization to the transversal plane.

In addition to the effect of relaxation linked with a delay before the readout, related to the notion of *echo time*, the relaxation effect may also happen during the readout itself. Run the simulation without the previous delay, but with a very long dwell time of 3 ms -- remember to recompute the gradient amplitude using the new dwell time. Plot both the signal magnitude and the reconstructed image and compare with the previous results.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_1d.py
            :lines: 68-69,102-106,109-121
            :dedent: 4
    
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 60-61
            :language: matlab
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 97-101,104-118
            :dedent: 4
            :language: matlab
    
    .. image:: image_1d_long_dwell_time.png
    
    With such a long dwell time, the readout lasts 450 ms. Large relaxation effects are visible in the image, with a global loss of both intensity and contrast.
    
    .. image:: signal_1d_long_dwell_time.png
    
    In addition to that, the signal is also very different: since the relaxation happens during the readout, the intensity of the signal will decrease with increasing time, and, according to the trajectory, with increasing k-space coordinates. The intensity of the central part, with respect to the left part, is not as high as before. Moreover, there is a strong asymmetry between the leftmost and the rightmost part of the k-space.

Spacing in the k-space and Aliasing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Re-run the simulation with a nominal dwell time (10 µs), and a k-space definition smaller than the object definition (e.g. 120 instead of 150), while keeping the same k-space extent (i.e. $k_{\max}$): compute the trajectory, gradient, signal, and image with the new parameters. Explain the changes in the image. What happens if the k-space definition is larger than the object definition?

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_1d.py
            :lines: 86-90,102-106,109-121
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 74-78
            :language: matlab
        .. literalinclude:: spatial_encoding_1d.m
            :lines: 97-101,104-118
            :dedent: 4
            :language: matlab
    
    .. image:: image_1d_aliased.png
    
    The reconstructed image has a smaller field-of-view than the object, caused by the larger k-space spacing: the field-of-view is now 12 cm while the object is 14 cm wide. Some aliasing occurs, where the leftmost part of the object is reconstructed on the right of the image, and the rightmost part of the object is reconstructed on the left of the image.
    
    When the k-space definition is larger or equal to the object definition, the field-of-view is wide enough and no aliasing occurs. The acquisition time will however increase with the field-of-view, as the number of points in the k-space trajectory will increase.

Two Dimensions (Zig-zag)
------------------------

In this part, we will simulate spatial encoding on a 2D object. Most of the notions seen in the previous section naturally extend to the 2D case, and it would be the same for the 3D case, not presented here in the interest of time.

Phantom Object
~~~~~~~~~~~~~~

Create a 2D object with five round regions, each having different values of $M_0$, $T_1$ and $T_2$. Note that the voxel size is larger than in the previous part in order to keep simulations fast.

.. tab:: Python
        
    .. literalinclude:: spatial_encoding_zig_zag.py
        :lines: 7-35
        :dedent: 4
.. tab:: MATLAB
    
    .. literalinclude:: spatial_encoding_zig_zag.m
        :lines: 1-33
        :language: matlab

.. image:: object_2d.png

Once the object is built, only keep the information where the "space" is not empty.

.. tab:: Python
    
    .. literalinclude:: spatial_encoding_zig_zag.py
        :lines: 46-50
        :dedent: 4
.. tab:: MATLAB
    
    .. literalinclude:: spatial_encoding_zig_zag.m
        :lines: 40-44
        :language: matlab

K-space and Trajectory
~~~~~~~~~~~~~~~~~~~~~~

Assuming that the voxel size is isotropic (i.e. the same on both axes), compute the extent and voxel size of the k-space. Discuss the differences with the 1D case.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_zig_zag.py
            :lines: 52-54
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_zig_zag.m
            :lines: 46-48
            :language: matlab
    
    The k-space extent of the 2D case is lower than in the 1D case (1256 rad/m vs. 6283 rad/m). This is caused by the difference in voxel size: a smaller voxel size will yield a larger k-space extent.
    
    The k-space resolution is similar in both cases (42 rad/m in 1D, 43 rad/m in 2D): reconstructed images will have a similar field of view.

Create a zig-zag trajectory through the k-space, starting for the lower left, as shown on the following figure. This trajectory must sample all points which are a multiple of $\Delta_k$, the k-space resolution. Assuming a dwell time of 10 µs, after which duration does the trajectory reach the center of the k-space? Discuss with respect to the $T_2$ values of the object.

.. image:: trajectory_zig_zag.png

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_zig_zag.py
            :lines: 131-140
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_zig_zag.m
            :lines: 114-126
            :dedent: 4
            :language: matlab
    
    The center of the k-space, which contains most of the information about the structure of the image, is reached after 4.64 ms. This is much lower than the $T_2$ of the top left and bottom right objects, and no discernible relaxation effect should be observed for those. The central object has however a very short $T_2$ of 1 ms: we should expect a very low signal in this object due to the relaxation.

As for the 1D case, sample the k-space using your trajectory after a 90° RF pulse, display the magnitude of the signal and compare with the observation in the 1D case.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_zig_zag.py
            :lines: 66, 69-71, 104-123
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_zig_zag.m
            :lines: 59,66-68
            :language: matlab
        .. literalinclude:: spatial_encoding_zig_zag.m
            :lines: 85-106
            :dedent: 4
            :language: matlab
    
    .. image:: signal_zig_zag.png
    
    As for the 1D case, the magnitude of the signal is highest at the center of the k-space. The cause of this is the same as in the 1D case.

Reconstruction
~~~~~~~~~~~~~~

Reconstruct the image using the Fourier transform of the signal, plot the magnitude and discuss the results.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_zig_zag.py
            :lines: 79
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_zig_zag.m
            :lines: 72
            :language: matlab
    
    .. image:: image_zig_zag.png
    
    The Fourier transform must be applied on both axes to recover the image, hence the use of the ``fftn`` function. The overall contrast is based on both $M_0$ and $T_2$: the top-left object is brighter than the bottom-right object (different $M_0$, same $T_2$), and the top-right object (same $M_0$, different $T_2$). The signal from the central object is almost 0 due to the longitudinal relaxation which happened by the time we reached the center of the k-space, where most of the contrast information is stored.
    
    Gibbs ringing is also visible, both within and outside the objects.

Effect of Dwell Time
~~~~~~~~~~~~~~~~~~~~

Re-run the experiment with a long dwell time of 700 µs. Recompute the gradient, simulation and reconstruction. Explain the resulting signal and image.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: spatial_encoding_zig_zag.py
            :lines: 86-88,107-110,114-123
            :dedent: 4
    .. tab:: MATLAB
        
        .. literalinclude:: spatial_encoding_zig_zag.m
            :lines: 75-77
            :language: matlab
        .. literalinclude:: spatial_encoding_zig_zag.m
            :lines: 88-91,88-106
            :dedent: 4
            :language: matlab
    
    .. image:: signal_zig_zag_long_dwell_time.png
    
    The signal show large signal inhomogeneities, as in the 1D case: the intensity is higher on the upper part of the k-space, where the sampling starts. There is still a high-intensity area in the center of the k-space, but not as much as in the simulation with the short swell time.
    
    .. image:: image_zig_zag_long_dwell_time.png
    
    This specific structure of the k-space defines the aspect of the image. The boundaries around objects is particularly marked due to the high frequency content of the k-space: high frequencies correspond to rapid changes in the image, notably edges. On the other hand, the lack of contrast between the two visible objects -- the $T_2$ of the three others is low enough so that their transversal magnetization has completely decayed during the first lines of the readout -- comes from the lower intensity of the signal in the center of the k-space, which contains low frequencies.
