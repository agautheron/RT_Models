Quantification
==============

*Section authors:* Olivier Girard <olivier.girard@univ-amu.fr>, Julien Lamy <lamy@unistra.fr>, Paulo L. de Sousa <ploureiro@unistra.fr>

Analytical Description
----------------------

The $T_1$ model presented here is inspired by the following references:

- *Biexponential Longitudinal Relaxation in White Matter: Characterization and Impact on T1 Mapping with IR-FSE and MP2RAGE*. Rioux et al. `DOI 10.1002/mrm.25729 <https://doi.org/10.1002/mrm.25729>`_
- *Quantitative Magnetization Transfer Imaging in Human Brain at 3 T via Selective Inversion Recovery*. Dortch et al. `DOI 10.1002/mrm.22928 <https://doi.org/10.1002/mrm.22928>`_

The evolution of the longitudinal magnetizations $M_z^a$ and $M_z^b$ of a two-pools model with exchange can be characterized by five quantities:

- $M_0^a$ and $M_0^b$, the equilibrium magnetization of both pools
- Their longitudinal relaxation times $T_1^a$ and $T_1^b$ (expressed in s), or, equivalently, their longitudinal relaxation rates $R_1^a$ and $R_1^b$ (expressed in Hz)
- The exchange constant $R$, expressed in Hz.

The exchange constant can also be expressed as the pool-wise magnetization exchange rates $k^{ab} = R M_0^b$ and $k^{ba} = R M_0^a$.

The evolution of the magnetization can then be written as

$$\begin{align*}
\frac{\partial \vec{M}}{\partial t} &= \hat{A} \cdot \vec{M} + \vec{B}\\
&= \begin{bmatrix} -(R_1^a + k^{ab}) & k^{ba}\\k^{ab} & -(R_1^b + k^{ba}) \end{bmatrix} \cdot \begin{bmatrix}M_z^a\\ M_z^b\end{bmatrix} + \begin{bmatrix}R_1^a \times M_0^a \\ R_1^b \times M_0^b\end{bmatrix}
\end{align*}$$

When the matrix $\hat{A}$ and the vector $\vec{B}$ do not depend on time, the general solution to this equation is given by:

$$
\vec{M}(t +dt) = \exp\left(\hat{A} \times dt\right) \cdot \vec{M}(t) + \hat{A}^{-1} \cdot \left(\exp\left(\hat{A} \times dt\right) - \mathbb{\hat{I}}_2\right) \cdot \vec{B}
$$

Given $M_0^a$ = 1, $M_0^b$ = 0.1, $R$ = 15 s⁻¹, $T_1^a$ = 1.1 s, $T_1^b$ = 0.2 s, and a time step of 5 ms, write the different matrices and vectors of the model for the exchanging and non-exchanging ($R$ = 0 s⁻¹) cases. The matrix exponential and inverse are called `scipy.linalg.expm` and `scipy.linalg.inv` in Python (don't forget to import `scipy`), and `expm` and `inv` in MATLAB. 

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: quantification_T1.py
            :lines: 1-37
    
    .. tab:: MATLAB
        
        .. literalinclude:: quantification_T1.m
            :lines: 1-33
            :language: matlab

Starting from a fully inverted magnetization in pool $a$ ($M_{ini}^a = -M_0^a$) and from a partially saturated magnetization in pool $b$ ($M_{ini}^b = 0.9 M_0^b$), compute the evolution of the magnetization over 5 s, plot the signal of both pools for the exchanging and non exchanging case, and the normalized signal of the exchanging pools. Adjust the exchange constant to reach the fast exchange ($R \rightarrow +\infty$) and slow exchange ($R \rightarrow 0$) limits, and re-run the simulations with multiple values of $M_{ini}^a$ and $M_{ini}^a$ to understand the influence of the parameters.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: quantification_T1.py
            :lines: 39-76
    
    .. tab:: MATLAB
        
        .. literalinclude:: quantification_T1.m
            :lines: 35-74
            :language: matlab
    
    .. image:: quantification_T1_BM.png

Fitting a Bi-exponential Model
------------------------------

Simulate a noisy MRI signal by adding normally distributed noise to the normalized signal of the first pool ($M^a/M_0^a$). This assumes that the second pool has a very short $T_2$ and has relaxed by the time of the readout.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: quantification_T1.py
            :lines: 82-98
    
    .. tab:: MATLAB
        
        .. literalinclude:: quantification_T1.m
            :lines: 79-98
            :language: matlab
    
    .. image:: quantification_T1_BM_noisy.png

The analytical solution [Rioux et al, Dortch et al] for the longitudinal magnetization of the visible protons, normalized to its equilibrium value $m^a_\square = M^a_\square / M^a_0$, contains two relaxation rates, a short and a long component:

$$m^a_\square(t) = 1 + b^S \exp\left(-t\ R_1^S\right) + b^L \exp\left(-t\ R_1^L\right)$$

In this model, the parameters are given by

$$\begin{align*}
R_1^S &= \frac{1}{2} \left(R_1^a + R_1^b + k^{ab} + k^{ba} + \sqrt{(R_1^a - R_1^b + k^{ab} - k^{ba})^2 + 4 k^{ab} k^{ba}}\right) \\
R_1^L &= \frac{1}{2} \left(R_1^a + R_1^b + k^{ab} + k^{ba} - \sqrt{(R_1^a - R_1^b + k^{ab} - k^{ba})^2 + 4 k^{ab} k^{ba}}\right) \\
b^S &= \frac{(m^a_\square(0) - 1) (R_1^a - R_1^L)  + (m^a_\square(0) - m^b_\square(0)) k^{ab}}{R_1^S - R_1^L} \\
b^L &= \frac{(m^a_\square(0) - 1) (R_1^a - R_1^S)  + (m^a_\square(0) - m^b_\square(0)) k^{ab}}{R_1^S - R_1^L}
\end{align*}$$

Compute the values of $R_1^{S,L}$ and $b^{S,L}$ using the true values of $T_1^{a,b}$ and $k^{ab,ba}$. Fit the bi-exponential model to the noisy data using the true values as initialization, compare the fitted parameters to the true parameters and the fitted signal to the signal from the previous analytical model. Compute and store the covariance matrix of the fit.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: quantification_T1.py
            :lines: 104-154
    
    .. tab:: MATLAB
        
        .. literalinclude:: quantification_T1.m
            :lines: 103-191
            :language: matlab
    
    .. image:: quantification_T1_fit.png

Monte Carlo Simulations
-----------------------

Run Monte Carlo simulations of the bi-exponential model by adding a different random noise to the signal for 300 runs. Store the fitted parameters of the 300 runs, compute their noise and standard deviation. Compare the distributions of the Monte Carlo parameters to the fitted parameters and covariance of the first fit, and plot the histograms of the Monte Carlo parameters.

.. solution::
    
    .. tab:: Python
        
        .. literalinclude:: quantification_T1.py
            :lines: 166-
    
    .. tab:: MATLAB
        
        .. literalinclude:: quantification_T1.m
            :lines: 206-
            :language: matlab
    
    .. image:: quantification_T1_monte_carlo.png
