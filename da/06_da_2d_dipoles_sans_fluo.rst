DA 2D — Méthode des Dipôles sans Fluorescence
==============================================

Introduction
------------

On considère ici le cas **2D** réaliste : le milieu est semi-infini, homogène, la
source est un faisceau **collimaté ponctuel** d'irradiance $F_0$ en $\rho = 0$,
s'atténuant exponentiellement en profondeur. La fluence dépend à la fois de la
distance radiale $\rho = \sqrt{x^2+y^2}$ et de la profondeur $z$. La méthode des
dipôles construit la solution par superposition de fonctions de Green de Yukawa 3D.

Géométrie et Terme Source
--------------------------

Milieu semi-infini $z \ge 0$, paramètres $\mu_a$, $\mu_s'$,
$D = 1/[3(\mu_a+\mu_s')]$, $\delta = \sqrt{D/\mu_a}$, $z_b = 2AD$.

La source est un faisceau pencil beam en $\rho = 0$ qui dépose ses photons diffus
selon une distribution exponentielle :

$$S(\mathbf{r}) = F_0\,\mu_s'\,e^{-\mu_t z}\,\delta^{(2)}(\boldsymbol{\rho})$$

où $\delta^{(2)}$ est le Dirac 2D transverse. La profondeur caractéristique est
$z_0 = 1/\mu_t$.

Équation Gouvernante
---------------------

$$-D\,\nabla^2\Phi(\mathbf{r}) + \mu_a\,\Phi(\mathbf{r}) = F_0\,\mu_s'\,e^{-\mu_t z}\,\delta^{(2)}(\boldsymbol{\rho})$$

Fonction de Green 3D (Yukawa)
------------------------------

La solution fondamentale en espace infini pour une source ponctuelle $\delta^{(3)}$ est :

.. math::

	G_\infty(\mathbf{r},\mathbf{r}_0) = \frac{1}{4\pi D}\,\frac{e^{-|\mathbf{r}-\mathbf{r}_0|/\delta}}{|\mathbf{r}-\mathbf{r}_0|}

Solution par Superposition — Intégrale sur la Source
------------------------------------------------------

En utilisant la linéarité, la solution est la convolution de $G_\infty$ avec la
distribution source sur l'axe $\rho = 0$ :

$$\Phi(\rho,z) = F_0\,\mu_s' \int_0^\infty e^{-\mu_t z'}\,G_m(\rho,z,z')\,dz'$$

où $G_m$ est la fonction de Green avec condition aux limites extrapolée
(dipôle réel en $z'$ + image en $-(z'+2z_b)$) :

.. math::

	G_m(\rho,z,z') = \frac{1}{4\pi D}\left[
	\frac{e^{-r_+/\delta}}{r_+} - \frac{e^{-r_-/\delta}}{r_-}
	\right]

$$r_+ = \sqrt{\rho^2+(z-z')^2}, \qquad r_- = \sqrt{\rho^2+(z+z'+2z_b)^2}$$

**Approximation dipôlaire.** En pratique $1/\mu_t \ll \delta$ (le terme source
est très localisé devant la longueur de diffusion), ce qui permet d'approcher
$\mu_t e^{-\mu_t z'} \approx \delta(z'-z_0)$ avec $z_0 = 1/\mu_t$. La solution
se réduit alors à la **forme explicite dipôle** :

.. math::

	\boxed{
	\Phi(\rho,z) = \frac{F_0\,\mu_s'}{4\pi D\,\mu_t}\left[
	\frac{e^{-\rho_+/\delta}}{\rho_+} - \frac{e^{-\rho_-/\delta}}{\rho_-}
	\right]
	}

avec :

$$\rho_+ = \sqrt{\rho^2+(z-z_0)^2} \quad\text{(source réelle)}$$
$$\rho_- = \sqrt{\rho^2+(z+z_0+2z_b)^2} \quad\text{(source image)}$$

.. solution::

   L'intégrale $\int_0^\infty e^{-\mu_t z'}\,e^{-|z-z'|/\delta}/|z-z'|\,dz'$
   n'a pas de forme explicite simple en général. L'approximation
   $\mu_t e^{-\mu_t z'} \approx \delta(z' - 1/\mu_t)$ est valide quand
   $1/\mu_t \ll \delta$, c'est-à-dire $\mu_t \gg \mu_\text{eff} = 1/\delta$.
   Cette condition est bien satisfaite en tissu biologique où $\mu_t \sim 10$–$100\,\mu_\text{eff}$.

Réflectance de Surface en $z = 0$
-----------------------------------

La **réflectance** (flux sortant en surface par unité de surface) est :

$$R(\rho) = \left.-D\,\frac{\partial\Phi}{\partial z}\right|_{z=0}$$

En calculant $\partial_z(e^{-\rho/\delta}/\rho)|_{z=0}$ :

.. math::

	\boxed{
	R(\rho) = \frac{F_0\,\mu_s'}{4\pi\,\mu_t}\left[
	z_0\left(\frac{1}{\delta}+\frac{1}{\rho_+}\right)\frac{e^{-\rho_+/\delta}}{\rho_+^2}
	+ (z_0+2z_b)\left(\frac{1}{\delta}+\frac{1}{\rho_-}\right)\frac{e^{-\rho_-/\delta}}{\rho_-^2}
	\right]
	}

avec $\rho_+ = \sqrt{\rho^2+z_0^2}$ et $\rho_- = \sqrt{\rho^2+(z_0+2z_b)^2}$.

Comportements Asymptotiques
----------------------------

**Proche de la source** ($\rho \to 0$) : la source réelle domine ($\rho_- \gg \rho_+$) :

$$R(\rho) \xrightarrow{\rho\to 0} \frac{F_0\,\mu_s'}{4\pi\,\mu_t}\,
z_0\left(\frac{1}{\delta}+\frac{1}{\rho_+}\right)\frac{e^{-\rho_+/\delta}}{\rho_+^2}$$

**Loin de la source** ($\rho \gg \delta$) : un ajustement semi-logarithmique
de $\rho^2 R(\rho)$ donne directement $\delta$, puis $\mu_a$ et $\mu_s'$.

Réponse Impulsionnelle (TPSF)
------------------------------

Pour une source impulsionnelle $F_0\,\delta(t)\,e^{-\mu_t z}\,\delta^{(2)}(\boldsymbol{\rho})$,
la fluence temporelle est :

$$\Phi(\rho,z,t) = \frac{F_0\,\mu_s'}{\mu_t}\,\frac{c}{(4\pi Dct)^{3/2}}\,e^{-\mu_a ct}
\left[e^{-\rho_+^2/(4Dct)} - e^{-\rho_-^2/(4Dct)}\right]$$

La réflectance temporelle (TPSF) en $z = 0$ :

$$R(\rho,t) = \frac{F_0\,\mu_s'}{\mu_t}\,\frac{c}{2(4\pi Dc)^{3/2}}\,t^{-5/2}\,e^{-\mu_a ct}
\left[z_0\,e^{-\rho_+^2/(4Dct)} + (z_0+2z_b)\,e^{-\rho_-^2/(4Dct)}\right]$$

La décroissance en $e^{-\mu_a ct}$ pour les grands $t$ permet d'extraire $\mu_a$
indépendamment de $\mu_s'$.

Extension : Milieu Multicouche (Slab)
--------------------------------------

Pour un milieu à deux interfaces (slab d'épaisseur $L$), la méthode des images génère
une série infinie de sources images en $z_{+,m} = 2m(L+2z_b)+z_0$ et
$z_{-,m} = 2m(L+2z_b)-z_0-2z_b$, $m \in \mathbb{Z}$. La convergence est rapide
car les termes décroissent en $e^{-2mL/\delta}$.

.. seealso::

   :doc:`04_da_1d_dipoles_sans_fluo` — cas 1D (plan infini) plus simple.

   :doc:`07_da_2d_dipoles_avec_fluo` — extension au cas fluorescent.

   :doc:`08_da_2d_kienle_sans_fluo` — résolution équivalente par fréquences spatiales.
