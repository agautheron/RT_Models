DA 2D — Méthode des Dipôles avec Fluorescence
==============================================

Introduction
------------

On étend ici la résolution 2D par dipôles (voir :doc:`06_da_2d_dipoles_sans_fluo`)
au cas **fluorescent**. La source d'excitation est un faisceau collimaté ponctuel
$F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$. Le système de deux équations
de diffusion couplées (voir :doc:`../base/02_fluorescence_etr`) est résolu séquentiellement :
d'abord le champ d'excitation $\Phi_x(\rho,z)$, puis le champ d'émission
$\Phi_m(\rho,z)$ en utilisant $\Phi_x$ comme terme source distribué.

Système d'Équations de Diffusion 2D
--------------------------------------

**Excitation :**

$$-D_x\,\nabla^2\Phi_x + \mu_{ax}^\text{tot}\,\Phi_x
= F_0\,\mu_{sx}'\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$$

avec $\mu_{ax}^\text{tot} = \mu_{ax}+\mu_{af}$, $D_x = 1/[3\,\mu_{tx}]$,
$\delta_x = \sqrt{D_x/\mu_{ax}^\text{tot}}$, $z_{0x} = 1/\mu_{tx}$.

**Émission (CW) :**

$$-D_m\,\nabla^2\Phi_m + \mu_{am}\,\Phi_m = \eta\,\mu_{af}\,\Phi_x(\mathbf{r})$$

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

En substituant la forme analytique de $\Phi_x$ (deux fonctions de Yukawa pondérées par
$F_0\mu_{sx}'/(\mu_{tx})$), l'intégrale de convolution se calcule analytiquement
grâce à l'identité :

.. math::

	\int_{\mathbb{R}^3} \frac{e^{-|\mathbf{r}-\mathbf{r}'|/\delta_x}}{|\mathbf{r}-\mathbf{r}'|}
	\cdot \frac{e^{-|\mathbf{r}'-\mathbf{r}''|/\delta_m}}{|\mathbf{r}'-\mathbf{r}''|}\,d^3r'
	= \frac{4\pi\delta_m^2\delta_x^2}{\delta_x^2-\delta_m^2}
	\left[\frac{e^{-|\mathbf{r}-\mathbf{r}''|/\delta_m}}{|\mathbf{r}-\mathbf{r}''|}
    -\frac{e^{-|\mathbf{r}-\mathbf{r}''|/\delta_x}}{|\mathbf{r}-\mathbf{r}''|}\right]

La solution finale est une **combinaison de quatre fonctions de Yukawa**
(sources réelle et image à $\delta_x$ et à $\delta_m$) :

.. math::

	\boxed{
	\Phi_m(\rho,z) = \frac{\eta\,\mu_{af}\,F_0\,\mu_{sx}'}{4\pi\,D_m\,\mu_{tx}}\,\frac{\delta_m^2}{\delta_x^2-\delta_m^2}
	\sum_{\pm}(\pm1)\left[
	  \frac{e^{-\rho_{x\pm}/\delta_x}}{\rho_{x\pm}} - \frac{e^{-\rho_{x\pm}/\delta_m}}{\rho_{x\pm}}
	  - \frac{e^{-\rho_{m\pm}/\delta_x}}{\rho_{m\pm}} + \frac{e^{-\rho_{m\pm}/\delta_m}}{\rho_{m\pm}}
	\right]
	}

où $\rho_{m\pm}$ désigne les distances aux sources images de l'équation d'émission
($z_{0x}$ replacé par $z_{0x}$ dans le milieu d'émission avec $z_{bm}$).

.. note::

   Le préfacteur $F_0\,\mu_{sx}'/\mu_{tx}$ apparaît naturellement via l'amplitude de
   $\Phi_x$ : par rapport à la formule avec source Dirac, il suffit de remplacer
   l'amplitude unitaire par $F_0\,\mu_{sx}'/\mu_{tx}$.

Réflectance de Fluorescence en $z = 0$
----------------------------------------

La réflectance d'émission mesurable en surface est :

$$R_m(\rho) = \left.-D_m\,\frac{\partial\Phi_m}{\partial z}\right|_{z=0}$$

Elle s'obtient par dérivation terme à terme de $\Phi_m$, suivant la même procédure
que pour $R(\rho)$ dans :doc:`06_da_2d_dipoles_sans_fluo`. C'est la grandeur inversée
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
