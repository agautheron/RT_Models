Bloch Equation
==============

*Section author:* Julien Lamy <lamy@unistra.fr>

In a typical MRI experiment, we assume that the total magnetic field $\vec{B}(t)$ at time $t$ is the sum of a static field with magnitude $B_0$ (in T) along the longitudinal $z$ axis, and of a time-varying field in the transversal $xy$ plane $\vec{B_1}(t)=[B_x(t),\ B_y(t),\ 0]$: that is, $\vec{B}(t) = [B_x(t),\ B_y(t),\ B_0]$.

Given a material with gyromagnetic ratio $\gamma$, with relaxation times $T_1$ and $T_2$ (or relaxation rates $R_1$ and $R_2$), and with equilibrium magnetization $M_0$, the motion of the magnetization vector is described by the Bloch equation, which can be written in matrix form:

.. math::
    \begin{align*}
        \frac{\d\vec{M}(t)}{\dt} = &
            \purple{\vec{M}(t) \times \gamma \vec{B_0}}
            \red{+ \vec{M}(t) \times \gamma \vec{B_1}(t)} \\
        & 
            \green{
                - \begin{bmatrix}R_2 & 0 & 0 \\ 0 & R_2 & 0 \\ 0 & 0 & R_1
            \end{bmatrix}
            \vec{M}(t)
            + \begin{bmatrix}0 \\ 0 \\ M_z^{eq} R_1\end{bmatrix}} \\
        
        = &
            \purple{
                \gamma \begin{bmatrix}
                    0 & B_0 & 0 \\
                    -B_0 & 0 & 0 \\
                    0 & 0 & 0
                \end{bmatrix}
                \vec{M}(t)}
            
            \red{
                + \gamma \begin{bmatrix}
                    0 & 0 & -B_y(t) \\
                    0 & 0 & B_x(t) \\
                    B_y(t) & -B_x(t) & 0
                \end{bmatrix}
                \vec{M}(t)} \\
        & 
            \green{
                - \begin{bmatrix}R_2 & 0 & 0 \\ 0 & R_2 & 0 \\ 0 & 0 & R_1
            \end{bmatrix}
            \vec{M}(t)
            + \begin{bmatrix}0 \\ 0 \\ M_z^{eq} R_1\end{bmatrix}}
    \end{align*}

It is usually simpler to consider this equation in a frame of reference which rotates around the $z$ axis at a frequency $\omega_0 = \gamma B_0 - \Delta\omega$, chosen to be the reference frequency of the MR scanner. We will also consider that $\vec{B_1}(t) = [B_1 \cos ω_0t,\ B_1 \sin ω_0t,\ 0]$. Under these two assumptions, the Bloch equation can be rewritten as:

.. math::
    \frac{\d\vec{M}(t)}{\dt} = 
        \begin{bmatrix}
            0 & \purple{\Delta\omega} & 0 \\
            \purple{-\Delta\omega} & 0 & \red{\gamma B_1} \\
            0 & \red{-\gamma B_1} & 0
        \end{bmatrix}
        \vec{M}(t)
        + \green{\begin{bmatrix}
            -R_2 & 0 & 0 \\
            0 & -R_2 & 0 \\
            0 & 0 & -R_1
        \end{bmatrix}}
        \vec{M}(t)
        + \green{\begin{bmatrix}0 \\ 0 \\ M_0 R_1\end{bmatrix}}

From this form, we can see that in the rotating frame with an harmonic $\vec{B_1}$ field, we have terms related to:

- the frequency offset between the reference frequency of the MRI and the Larmor frequency of the material (terms in $\purple{\Delta\omega}$)
- the amplitude of the $\vec{B_1}$ field (terms in $\red{\gamma B_1}$)
- the relaxation (terms in $\green{R_1}$ and $\green{R_2}$)

When the Larmor frequency of the material matches the reference frequency of the scanner, we have $\Delta\omega=0$, and this behavior is called *on-resonance*; when the two frequencies do not match, $\Delta\omega \ne 0$, and this behavior is called *off-resonance*.

Behavior With Only B₁
---------------------

When an RF-pulse is applied during an MR experiment, it is usually on-resonance, and during a time short enough to neglect the relaxation effects.

- Rewrite the Bloch equation for $\Delta\omega=0$, $T_1 \rightarrow \infty$, and $T_2 \rightarrow \infty$.
- Solve the equation and describe the motion of the magnetization for this specific case (hint: drop the $x$ component then rewrite in the complex $yz$ plane, i.e. $M_{yz} = M_y + i M_z$).

Reminder: given a function $y$ and two constants $a$ and $b$, the solution to the differential equation $\frac{\d y(t)}{\dt} = ay+b$ with given initial value $y(0)$ is $y(t)=\left(y(0)+\frac{b}{a}\right) e^{at}-\frac{b}{a}$.

.. solution::
    
    With a $B_1$ field, on-resonance and without relaxation, letting $\omega_1 = \gamma B_1$, the Bloch equation simplifies to:
    
    .. math::
        
        \frac{\d\vec{M}(t)}{\dt} = 
            \begin{bmatrix}
                0 & 0 & 0 \\ 0 & 0 & \omega_1 \\ 0 & -\omega_1 & 0
            \end{bmatrix}
            \vec{M}(t)
    
    By dropping the $x$ component, we get $\frac{\d M_y(t)}{\d t}=\omega_1 M_z$ and $\frac{\d M_z(t)}{\d t}=-\omega_1 M_y$. By re-writing the magnetization in the complex $yz$ plane, we have $M_{yz}(t) = M_y(t) + i M_z(t)$ and $\frac{\d M_{yz}}{\dt}(t) = \omega_1(M_z(t)-i M_y(t)) = -i\omega_1 M_{yz}(t)$.
    
    The solution to this is the exponential $M_{yz}(t) = e^{-i\omega_1 t}M_{yz}(0)$, showing that the effect of a $B_1$ field, on-resonance and without relaxation, is a rotation in the $yz$ plane, i.e. around the $x$ axis.

Behavior With Only Relaxation
-----------------------------

When the RF pulse is stopped, two phenomena happen simultaneously. We will start by studying the behavior of the system when $B_1 = 0$, on-resonance, with relaxation.

- Rewrite the Bloch equation for $B_1=0$ and $\Delta\omega=0$.
- Solve the equation and describe the motion of the magnetization in this case, in the transversal $xy$ plane and on the longitudinal axis $z$.

.. solution::
    
    With a $B_1=0$, on-resonance, the Bloch equation simplifies to:
    
    .. math::
        \frac{\d\vec{M}(t)}{\d t} = 
            \begin{bmatrix}
                -R_2 & 0 & 0 \\
                0 & -R_2 & 0 \\
                0 & 0 & -R_1
            \end{bmatrix}
            \vec{M}(t)
            + \begin{bmatrix}0 \\ 0 \\ M_0 R_1\end{bmatrix}
    
    Once again, we get simple exponential solutions. In the transersal $xy$ plane, the magnetization has an exponential decay:
    
    $$M_{x,y}(t) = e^{-t R_2} M_{x,y}(0)$$
    
    On the longitudinal axis, the magnetization recovers towards $M_0$:
    
    $$M_z(t) = (M_z(0)-M_0) e^{-t R_1}+M_0$$
    
    or
    
    $$M_z(t) = M_z(0) e^{-t R_1} + M_0(1-e^{-t R_1})$$

Behavior With Only Off-resonance
--------------------------------

We now study the behavior of the system when $B_1 = 0$, without relaxation, off-resonance.

- Rewrite the Bloch equation for $B_1=0$, $T_1\rightarrow\infty$ and $T_2\rightarrow\infty$.
- Solve the equation and describe the motion of the magnetization in this case (hint: the simplified equation should look familiar).

.. solution::
    
    In this particular case, the Bloch equation simplifies to:
    
    .. math:: 
        
        \frac{\d\vec{M}(t)}{\dt} = 
            \begin{bmatrix}
                0 & \Delta\omega & 0 \\
                -\Delta\omega & 0 & 0 \\
                0 & 0 & 0
            \end{bmatrix}
            \vec{M}(t)
    
    By applying the same method as in the $\vec{B_1} \ne 0$ case in the complex $xy$ plane, we get:
    
    $$M_{xy}(t) = e^{-i\Delta\omega t}M_{xy}(0)$$
    
    This shows that with no $\vec{B_1}$ and no relaxation, off-resonance, the magnetization precesses in the $xy$ plane, around the $z$ axis.

Simulation of a Simple Experiment
---------------------------------

The simulator used in some of these lab sessions is based on the previously-described solutions to the Bloch equation. We will not simulate the behavior of individual nuclei, but of groups of nuclei which share similar properties like equilibrium magnetization, resonance frequencies, or relaxation times. Such groups are called *isochromats*.

Start by downloading the simulator from the following links: `Python <../simulator.py>`__ version or `MATLAB <../Simulator.m>`__ version. In MATLAB, no external dependancy is used, although version ≥ R2020b is required; in Python, `numpy <https://numpy.org/>`_ `scipy <https://scipy.org>`_, and `matplotlib <https://matplotlib.org/>`_ are required.

The file with the source code in the language of your choice must be stored somewhere within the search paths of your environment, e.g. in the directory you will use for this project.

This section show how to simulate a simple NMR experiment: apply an RF pulse and simulate the evolution of the system. We start by creating the simulation environment: isochromats, defined by their $M_0$, $T_1$, $T_2$, and position -- we will see later that extra parameters can be added. Our initial situation is simple: a single isochromat at the center of space. Note that all quantities are expressed in their SI units.

.. tab:: Python
    
    .. literalinclude:: saturation_recovery.py
        :lines: 1-10

.. tab:: MATLAB
    
    .. literalinclude:: saturation_recovery.m
        :lines: 1-6

The basic features of the simulator are:

- Get the magnetization vector at each isochromat: ``simulator.magnetization``
- Apply an RF pulse: ``simulator.pulse(flip_angle)`` or ``simulator.pulse(flip_angle, phase)``, where the flip angle and the phase are specified in radians. Note that the phase is set to 0 in the first form and that in this model, RF pulses are assumed to have a 0 duration
- Keep the system idle for some time: ``simulator.idle(duration)``, where the duration is specified in seconds. This simulates the relaxation processes and potentially the free precession.

The evolution of the magnetization will be simulated for 1 s with a time step of 1 ms and this evolving magnetization will be stored in a 3D array: the first dimension is time (size 1002, the extra 2 are for the magnetization before the pulse, i.e. t=0, and just after the pulse, also at t=0 since pulse take no time), the second represents the isochromats (size 1), and the third stores the $x$, $y$, and $z$ components of the magnetization (size 3). We will also keep track of time at which the magnetization is simulated.

.. tab:: Python
    
    .. literalinclude:: saturation_recovery.py
        :lines: 12-14

.. tab:: MATLAB
    
    .. literalinclude:: saturation_recovery.m
        :lines: 8-10

Simulate the saturation:

.. tab:: Python
    
    .. literalinclude:: saturation_recovery.py
        :lines: 16-21

.. tab:: MATLAB
    
    .. literalinclude:: saturation_recovery.m
        :lines: 12-17

Simulate the recovery:

.. tab:: Python
    
    .. literalinclude:: saturation_recovery.py
        :lines: 23-26

.. tab:: MATLAB
    
    .. literalinclude:: saturation_recovery.m
        :lines: 19-23

Plot the evolution of each component of the magnetization:

.. tab:: Python
    
    .. literalinclude:: saturation_recovery.py
        :lines: 28-34

.. tab:: MATLAB
    
    .. literalinclude:: saturation_recovery.m
        :lines: 25-33

.. image:: saturation_recovery.png

Explain the following points of the simulation

- What happens at $t=0$?
- Why is the $M_x$ magnetization at 0 throughout the simulation ?
- Why is the $M_y$ magnetization negative? Why does it increases to 0?
- Why does the $M_z$ magnetization decreases to 0? Given enough time, which value would it reach?

.. solution::
    
    At t=0, the 90° RF pulse tips the equilibrium magnetization ($M_x=M_y=0$, $M_z=1$) to the transversal $xy$ plane. The angle that the magnetization vector takes in the transversal plane depends on the phase of the RF pulse: with a phase of 0°, the magnetization rotates around the $x$ axis, and, according to the right-hand rule, ends on the $-y$ axis.
    
    As time increases, the transversal magnetization (here on $M_y$) evolves towards 0 due to $T_2$ relaxation, and the longitudinal magnetization evolves towards 1, its equilibrium value. Since the time during which we ran the simulation is equal to $T_1$, the recovery is incomplete.
