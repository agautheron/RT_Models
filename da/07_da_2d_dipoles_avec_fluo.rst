DA 2D — Méthode des Dipôles avec Fluorescence
==============================================

Introduction
------------

On étend ici la résolution 2D par dipôles (voir :doc:`06_da_2d_dipoles_sans_fluo`)
au cas **fluorescent**. La source d'excitation est un faisceau collimaté ponctuel
$F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$. Le terme source d'émission
comprend **deux contributions** : les photons diffus $\Phi_x$ et les photons balistiques
$F_0 e^{-\mu_{tx}z}$ qui peuvent tous deux exciter les fluorophores.

Système d'Équations de Diffusion 2D
--------------------------------------

**Excitation :**

$$-D_x\,\nabla^2\Phi_x + \mu_{ax}^\text{tot}\,\Phi_x
= F_0\,\mu_{sx}'\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$$

avec $\mu_{ax}^\text{tot} = \mu_{ax}+\mu_{af}$, $D_x = 1/[3\,\mu_{tx}]$,
$\delta_x = \sqrt{D_x/\mu_{ax}^\text{tot}}$, $z_{0x} = 1/\mu_{tx}$.

**Émission (CW) :**

$$-D_m\,\nabla^2\Phi_m + \mu_{am}\,\Phi_m
= \eta\,\mu_{af}\!\left[\Phi_x(\mathbf{r}) + F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})\right]$$

Le terme source comprend deux contributions :

- $\eta\,\mu_{af}\,\Phi_x(\mathbf{r})$ — excitation par les photons **diffus**
- $\eta\,\mu_{af}\,F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$ — excitation par les photons **balistiques**

avec $D_m = 1/[3(\mu_{am}+\mu_{sm}')]$, $\delta_m = \sqrt{D_m/\mu_{am}}$.

Résolution — Champ d'Excitation
---------------------------------

Par l'approximation dipôlaire $\mu_{tx}\,e^{-\mu_{tx} z'} \approx \delta(z'-z_{0x})$
(voir :doc:`06_da_2d_dipoles_sans_fluo`), la solution est :

.. math::

	\Phi_x(\rho,z) = \frac{F_0\,\mu_{sx}'}{4\pi D_x\,\mu_{tx}}\left[
	\frac{e^{-\rho_{x+}/\delta_x}}{\rho_{x+}} - \frac{e^{-\rho_{x-}/\delta_x}}{\rho_{x-}}
	\right]

avec $\rho_{x+} = \sqrt{\rho^2+(z-z_{0x})^2}$ et
$\rho_{x-} = \sqrt{\rho^2+(z+z_{0x}+2z_{bx})^2}$.

Résolution — Champ d'Émission
--------------------------------

Par linéarité, on décompose $\Phi_m = \Phi_m^\text{balist} + \Phi_m^\text{diff}$.

**Contribution balistique** $\Phi_m^\text{balist}$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Le terme source $\eta\,\mu_{af}\,F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$
est une source axiale exponentielle. Par l'approximation dipôlaire appliquée au milieu
d'émission (propriétés $\delta_m$, $z_{bm}$), avec source en $z_{0x} = 1/\mu_{tx}$ :

.. math::

	\Phi_m^\text{balist}(\rho,z) = \frac{\eta\,\mu_{af}\,F_0}{4\pi D_m\,\mu_{tx}}\left[
	\frac{e^{-\rho_{m+}/\delta_m}}{\rho_{m+}} - \frac{e^{-\rho_{m-}/\delta_m}}{\rho_{m-}}
	\right]

avec $\rho_{m+} = \sqrt{\rho^2+(z-z_{0x})^2}$ et
$\rho_{m-} = \sqrt{\rho^2+(z+z_{0x}+2z_{bm})^2}$.

.. note::

   $\Phi_m^\text{balist}$ et $\Phi_x$ ont la même source géométrique ($z_{0x}$),
   mais se propagent avec les propriétés optiques du milieu d'**émission**
   ($\delta_m$, $z_{bm}$) et non d'excitation.

**Contribution diffuse** $\Phi_m^\text{diff}$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Le terme source $\eta\,\mu_{af}\,\Phi_x(\mathbf{r})$ est distribué dans tout le volume.
La solution par la méthode de Green 3D s'écrit :

$$\Phi_m^\text{diff}(\mathbf{r}) = \int_{\mathcal{V}} G_m(\mathbf{r},\mathbf{r}')\,\eta\,\mu_{af}\,\Phi_x(\mathbf{r}')\,d^3r'$$

où $G_m$ est la fonction de Green avec condition aux limites extrapolée :

.. math::

	G_m(\mathbf{r},\mathbf{r}') = \frac{1}{4\pi D_m}
	\left[\frac{e^{-|\mathbf{r}-\mathbf{r}'|/\delta_m}}{|\mathbf{r}-\mathbf{r}'|}
		 -\frac{e^{-|\mathbf{r}-\mathbf{r}'_\text{image}|/\delta_m}}{|\mathbf{r}-\mathbf{r}'_\text{image}|}
	\right]

En substituant la forme analytique de $\Phi_x$ et en utilisant l'identité de
convolution de deux fonctions de Yukawa ($\delta_x \neq \delta_m$) :

.. math::

	\int_{\mathbb{R}^3} \frac{e^{-|\mathbf{r}-\mathbf{r}'|/\delta_x}}{|\mathbf{r}-\mathbf{r}'|}
	\cdot \frac{e^{-|\mathbf{r}'-\mathbf{r}''|/\delta_m}}{|\mathbf{r}'-\mathbf{r}''|}\,d^3r'
	= \frac{4\pi\delta_m^2\delta_x^2}{\delta_x^2-\delta_m^2}
	\left[\frac{e^{-|\mathbf{r}-\mathbf{r}''|/\delta_m}}{|\mathbf{r}-\mathbf{r}''|}
    -\frac{e^{-|\mathbf{r}-\mathbf{r}''|/\delta_x}}{|\mathbf{r}-\mathbf{r}''|}\right]

on obtient :

.. math::

	\Phi_m^\text{diff}(\rho,z) = \frac{\eta\,\mu_{af}\,F_0\,\mu_{sx}'}{4\pi\,D_m\,\mu_{tx}}\,\frac{\delta_m^2}{\delta_x^2-\delta_m^2}
	\sum_{\pm}(\pm1)\left[
	  \frac{e^{-\rho_{x\pm}/\delta_x}}{\rho_{x\pm}} - \frac{e^{-\rho_{x\pm}/\delta_m}}{\rho_{x\pm}}
	  - \frac{e^{-\rho_{m\pm}/\delta_x}}{\rho_{m\pm}} + \frac{e^{-\rho_{m\pm}/\delta_m}}{\rho_{m\pm}}
	\right]

Solution Totale
~~~~~~~~~~~~~~~~

.. math::

	\boxed{\Phi_m(\rho,z) = \Phi_m^\text{balist}(\rho,z) + \Phi_m^\text{diff}(\rho,z)}

Réflectance de Fluorescence en $z = 0$
----------------------------------------

La réflectance d'émission mesurable en surface est :

$$R_m(\rho) = \left.-D_m\,\frac{\partial\Phi_m}{\partial z}\right|_{z=0}
= R_m^\text{balist}(\rho) + R_m^\text{diff}(\rho)$$

Elle s'obtient par dérivation terme à terme. C'est la grandeur inversée
en FDOT pour reconstruire $\mu_{af}(\mathbf{r})$.

Extension Temporelle
---------------------

En régime temporel, l'équation d'émission devient :

$$\frac{1}{c}\partial_t\Phi_m - D_m\nabla^2\Phi_m + \mu_{am}\Phi_m
= \frac{\eta\,\mu_{af}}{\tau_f}\int_{-\infty}^{t}e^{-(t-t')/\tau_f}
\!\left[\Phi_x(\mathbf{r},t') + F_0\,e^{-\mu_{tx} z}\,\delta(t')\,\delta^{(2)}(\boldsymbol{\rho})\right]dt'$$

En domaine de Laplace ($s = j\omega$), le terme source devient
$\frac{\eta\,\mu_{af}}{1+s\tau_f}\!\left[\tilde\Phi_x + F_0\,e^{-\mu_{tx}z}\,\delta^{(2)}\right]$,
et l'on remplace $\mu_a \leftarrow \mu_a + s/c$ dans chaque équation.

.. seealso::

   :doc:`05_da_1d_dipoles_avec_fluo` — cas 1D fluorescent plus simple.

   :doc:`06_da_2d_dipoles_sans_fluo` — cas 2D sans fluorescence.

   :doc:`09_da_2d_kienle_avec_fluo` — résolution équivalente par fréquences spatiales.
