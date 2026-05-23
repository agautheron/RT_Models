DA 2D — Méthode des Dipôles avec Fluorescence
==============================================

Introduction
------------

On étend ici la résolution 2D par dipôles (voir :doc:`06_da_2d_dipoles_sans_fluo`)
au cas **fluorescent**. Le système de deux équations de diffusion couplées
(voir :doc:`../base/02_fluorescence_etr`) est résolu séquentiellement : d'abord le champ
d'excitation $\Phi_x(r,z)$ par méthode des images, puis le champ d'émission
$\Phi_m(r,z)$ en utilisant $\Phi_x$ comme terme source distribué.

Système d'Équations de Diffusion 2D
--------------------------------------

**Excitation :**

$$-D_x\,\nabla^2\Phi_x + \mu_{ax}^\text{tot}\,\Phi_x = \delta^{(3)}(\mathbf{r}-\mathbf{r}_0)$$

avec $\mu_{ax}^\text{tot} = \mu_{ax}+\mu_{af}$, $D_x = 1/[3(\mu_{ax}^\text{tot}+\mu_{sx}')]$,
$\delta_x = \sqrt{D_x/\mu_{ax}^\text{tot}}$.

**Émission (CW) :**

$$-D_m\,\nabla^2\Phi_m + \mu_{am}\,\Phi_m = \eta\,\mu_{af}\,\Phi_x(\mathbf{r})$$

avec $D_m = 1/[3(\mu_{am}+\mu_{sm}')]$, $\delta_m = \sqrt{D_m/\mu_{am}}$.

Résolution — Champ d'Excitation
---------------------------------

La solution de l'équation d'excitation est identique au cas sans fluorescence
(voir :doc:`06_da_2d_dipoles_sans_fluo`), avec la longueur de diffusion $\delta_x$ :

.. math::

	\Phi_x(r,z) = \frac{1}{4\pi D_x}\left[
	\frac{e^{-\rho_{x+}/\delta_x}}{\rho_{x+}} - \frac{e^{-\rho_{x-}/\delta_x}}{\rho_{x-}}
	\right]

avec $\rho_{x\pm}$ définis par les positions de la source réelle $(z_0)$ et image
$(-(z_0+2z_{bx}))$.

Résolution — Champ d'Émission par Intégrale de Green
------------------------------------------------------

Le terme source $\eta\,\mu_{af}\,\Phi_x(\mathbf{r})$ est distribué dans tout le volume.
La solution par la méthode de Green 3D s'écrit :

$$\Phi_m(\mathbf{r}) = \int_{\mathcal{V}} G_m(\mathbf{r},\mathbf{r}')\,\eta\,\mu_{af}\,\Phi_x(\mathbf{r}')\,d^3r'$$

où $G_m$ est la fonction de Green de l'équation d'émission **avec condition aux
limites extrapolée** :

.. math::

	G_m(\mathbf{r},\mathbf{r}') = \frac{1}{4\pi D_m}
	\left[\frac{e^{-|\mathbf{r}-\mathbf{r}'|/\delta_m}}{|\mathbf{r}-\mathbf{r}'|}
		 -\frac{e^{-|\mathbf{r}-\mathbf{r}'_\text{image}|/\delta_m}}{|\mathbf{r}-\mathbf{r}'_\text{image}|}
	\right]

avec $\mathbf{r}'_\text{image} = (x', y', -(z'+2z_{bm}))$.

Expression Analytique Fermée
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En substituant la forme analytique de :math:`\Phi_x` (combinaison de deux fonctions de
Yukawa), l'intégrale de convolution se calcule analytiquement. Pour deux fonctions
de Yukawa de longueurs $\delta_x$ et $\delta_m$ différentes, on utilise l'identité :

.. math::

	\int_{\mathbb{R}^3} \frac{e^{-|\mathbf{r}-\mathbf{r}'|/\delta_x}}{|\mathbf{r}-\mathbf{r}'|}
	\cdot \frac{e^{-|\mathbf{r}'-\mathbf{r}''|/\delta_m}}{|\mathbf{r}'-\mathbf{r}''|}\,d^3r'
	= \frac{4\pi\delta_m^2\delta_x^2}{\delta_x^2-\delta_m^2}
	\left[\frac{e^{-|\mathbf{r}-\mathbf{r}''|/\delta_m}}{|\mathbf{r}-\mathbf{r}''|}
    -\frac{e^{-|\mathbf{r}-\mathbf{r}''|/\delta_x}}{|\mathbf{r}-\mathbf{r}''|}\right]

La solution finale est donc une **combinaison de quatre fonctions de Yukawa** à
longueur $\delta_m$ (terme homogène) plus **quatre termes à longueur $\delta_x$**
(terme particulier). En regroupant par paires (source réelle/image) :

.. math::

	\boxed{
	\Phi_m(r,z) = \frac{\eta\,\mu_{af}}{4\pi\,D_m}\,\frac{\delta_m^2}{\delta_x^2-\delta_m^2}
	\sum_{\pm}(\pm1)\left[
	  \frac{e^{-\rho_{x\pm}/\delta_x}}{\rho_{x\pm}} - \frac{e^{-\rho_{x\pm}/\delta_m}}{\rho_{x\pm}}
	  - \frac{e^{-\rho_{m\pm}/\delta_x}}{\rho_{m\pm}} + \frac{e^{-\rho_{m\pm}/\delta_m}}{\rho_{m\pm}}
	\right]
	}

où $\rho_{m\pm}$ désigne les distances aux sources images de l'équation d'émission.

Réflectance de Fluorescence en $z = 0$
----------------------------------------

La réflectance d'émission mesurable en surface est :

$$R_m(r) = \left.-D_m\,\frac{\partial\Phi_m}{\partial z}\right|_{z=0}$$

Elle s'obtient par dérivation terme à terme de $\Phi_m$, suivant la même procédure
que pour $R(r)$ dans :doc:`06_da_2d_dipoles_sans_fluo`. C'est la grandeur inversée
en FDOT pour reconstruire $\mu_{af}(\mathbf{r})$.

Extension Temporelle
---------------------

En régime temporel, l'équation d'émission devient une équation de convolution :

$$\frac{1}{c}\partial_t\Phi_m - D_m\nabla^2\Phi_m + \mu_{am}\Phi_m
= \frac{\eta\,\mu_{af}}{\tau_f}\int_{-\infty}^{t}e^{-(t-t')/\tau_f}\,\Phi_x(\mathbf{r},t')\,dt'$$

En domaine de Laplace ($s = j\omega$), le terme source devient
$\frac{\eta\,\mu_{af}}{1+s\tau_f}\,\tilde\Phi_x(\mathbf{r},s)$, et l'on remplace
$\mu_a \leftarrow \mu_a + s/c$ dans chaque équation. La transformée inverse donne
la TPSF de fluorescence.

.. seealso::

   :doc:`05_da_1d_dipoles_avec_fluo` — cas 1D fluorescent plus simple.

   :doc:`06_da_2d_dipoles_sans_fluo` — cas 2D sans fluorescence.

   :doc:`09_da_2d_kienle_avec_fluo` — résolution équivalente par fréquences spatiales.
