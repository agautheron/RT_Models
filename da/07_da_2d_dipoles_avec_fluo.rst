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

avec $D_m = 1/[3(\mu_{am}+\mu_{sm}')]$, $\delta_m = \sqrt{D_m/\mu_{am}}$.

Le terme source comprend deux contributions :

- $\eta\,\mu_{af}\,\Phi_x(\mathbf{r})$ — excitation par les photons **diffus**
- $\eta\,\mu_{af}\,F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$ — excitation par les photons **balistiques**

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
est une source axiale exponentielle. Par l'approximation dipôlaire en $z_{0x}$,
propagée dans le milieu d'émission ($\delta_m$, $z_{bm}$) :

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

Le terme source $\eta\,\mu_{af}\,\Phi_x(\mathbf{r})$ est distribué dans tout le
demi-espace. La solution formelle par la méthode de Green 3D est :

$$\Phi_m^\text{diff}(\mathbf{r}) = \eta\,\mu_{af}
\int_0^\infty\!\!\int_{\mathbb{R}^2} G_m(\mathbf{r},\mathbf{r}')\,\Phi_x(\mathbf{r}')\,d^2\rho'\,dz'$$

où la fonction de Green $G_m$ avec condition aux limites extrapolée est :

.. math::

	G_m(\mathbf{r},\mathbf{r}') = \frac{1}{4\pi D_m}
	\left[\frac{e^{-|\mathbf{r}-\mathbf{r}'|/\delta_m}}{|\mathbf{r}-\mathbf{r}'|}
		 -\frac{e^{-|\mathbf{r}-\bar{\mathbf{r}}'|/\delta_m}}{|\mathbf{r}-\bar{\mathbf{r}}'|}
	\right], \qquad \bar{\mathbf{r}}' = (x',y',-(z'+2z_{bm}))

**Pourquoi cette intégrale n'a pas de forme explicite dans l'espace réel.**
Il pourrait sembler naturel d'appliquer l'identité de convolution de Yukawa
(valable dans tout $\mathbb{R}^3$) :

.. math::

	\int_{\mathbb{R}^3} \frac{e^{-|\mathbf{r}-\mathbf{r}'|/\delta_x}}{|\mathbf{r}-\mathbf{r}'|}
	\cdot \frac{e^{-|\mathbf{r}'-\mathbf{r}_s|/\delta_m}}{|\mathbf{r}'-\mathbf{r}_s|}\,d^3r'
	= \frac{4\pi\delta_m^2\delta_x^2}{\delta_x^2-\delta_m^2}
	\left[\frac{e^{-|\mathbf{r}-\mathbf{r}_s|/\delta_m}}{|\mathbf{r}-\mathbf{r}_s|}
    -\frac{e^{-|\mathbf{r}-\mathbf{r}_s|/\delta_x}}{|\mathbf{r}-\mathbf{r}_s|}\right]

Cependant, le domaine d'intégration est le **demi-espace** $z' \geq 0$, et non
$\mathbb{R}^3$. L'identité ne peut donc **pas** être appliquée directement. En effet,
pour étendre l'intégrale à tout $\mathbb{R}^3$, il faudrait connaître la valeur de
$\Phi_x(\mathbf{r}')$ pour $z' < 0$, ce qui n'est pas défini par le problème physique.

.. solution::

   Plus précisément, en substituant $G_m = G_m^\infty - G_m^\infty(\cdot,\bar{\mathbf{r}}')$
   et en développant le produit avec $\Phi_x$, on obtient quatre intégrales de la forme :

   $$I_{ij} = \int_0^\infty\!\!\int_{\mathbb{R}^2}
   \frac{e^{-|\mathbf{r}-\mathbf{r}'|_i/\delta_m}}{|\mathbf{r}-\mathbf{r}'|_i}\,
   \frac{e^{-|\mathbf{r}'-\mathbf{r}_j|/\delta_x}}{|\mathbf{r}'-\mathbf{r}_j|}\,d^3r'$$

   avec $(i,j) \in \{+,-\}\times\{+,-\}$ et $z'$ borné à $[0,+\infty)$.
   L'intégration transverse sur $(\rho',\phi')$ se fait analytiquement par transformée
   de Hankel, mais l'intégrale résiduelle en $z'$ ne se simplifie pas en une fonction
   élémentaire. La forme analytique explicite n'existe que dans l'espace de Fourier
   (transformée de Hankel en $s_r$), qui est précisément ce que calcule la méthode de
   Kienle (:doc:`09_da_2d_kienle_avec_fluo`).

**Résultat sous forme d'intégrale 1D.** En appliquant la transformée de Hankel en
$\rho$, le produit de convolution transverse se factorise et l'on obtient l'intégrale
1D en $z'$ :

.. math::

	\tilde{\Phi}_m^\text{diff}(s_r,z)
	= \frac{\eta\,\mu_{af}}{D_m}\int_0^\infty
	  \tilde{G}_m(s_r,z,z')\,\tilde{\Phi}_x(s_r,z')\,dz'

avec $\tilde{G}_m(s_r,z,z') = \dfrac{e^{-\alpha_m|z-z'|}-e^{-\alpha_m(z+z'+2z_{bm})}}{2\alpha_m D_m}$,
$\alpha_m = \sqrt{s_r^2+1/\delta_m^2}$, et $\tilde{\Phi}_x(s_r,z')$ donné par
:doc:`08_da_2d_kienle_sans_fluo`.

Cette intégrale est calculée **analytiquement** dans la méthode de Kienle
(:doc:`09_da_2d_kienle_avec_fluo`), ou **numériquement** en $z'$ puis inversée par
transformée de Hankel numérique pour obtenir $\Phi_m^\text{diff}(\rho,z)$.

Solution Totale
~~~~~~~~~~~~~~~~

.. math::

	\boxed{\Phi_m(\rho,z) = \Phi_m^\text{balist}(\rho,z) + \Phi_m^\text{diff}(\rho,z)}

Réflectance de Fluorescence en $z = 0$
----------------------------------------

La réflectance d'émission mesurable en surface est :

$$R_m(\rho) = \left.-D_m\,\frac{\partial\Phi_m}{\partial z}\right|_{z=0}
= R_m^\text{balist}(\rho) + R_m^\text{diff}(\rho)$$

**Contribution balistique** (forme analytique explicite) :

.. math::

	R_m^\text{balist}(\rho)
	= \frac{\eta\,\mu_{af}\,F_0}{4\pi\,\mu_{tx}}
	\left[
	  \frac{z_{0x}}{\rho_{m+}^3}\left(1+\frac{\rho_{m+}}{\delta_m}\right)e^{-\rho_{m+}/\delta_m}
	+ \frac{z_{0x}+2z_{bm}}{\rho_{m-}^3}\left(1+\frac{\rho_{m-}}{\delta_m}\right)e^{-\rho_{m-}/\delta_m}
	\right]

**Contribution diffuse** (calcul par transformée de Hankel inverse, voir :doc:`09_da_2d_kienle_avec_fluo`) :

$$R_m^\text{diff}(\rho) = \frac{1}{2\pi}\int_0^\infty \tilde{R}_m^\text{diff}(s_r)\,J_0(s_r\rho)\,s_r\,ds_r$$

C'est la grandeur inversée en FDOT pour reconstruire $\mu_{af}(\mathbf{r})$.

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

   :doc:`09_da_2d_kienle_avec_fluo` — résolution analytique explicite via fréquences spatiales.
