DA 2D — Méthode des Dipôles sans Fluorescence
==============================================

Introduction
------------

On considère ici le cas **2D** réaliste : le milieu est semi-infini, homogène, la
source est **ponctuelle** (et non plus plane), et la fluence dépend à la fois de la
distance radiale $r = \sqrt{x^2+y^2}$ et de la profondeur $z$. La méthode des
dipôles construit la solution par superposition de fonctions de Green de Yukawa 3D,
en ajoutant une source image négative pour satisfaire la condition aux limites extrapolée.

Géométrie et Équation Gouvernante
-----------------------------------

Milieu semi-infini $z \ge 0$, paramètres optiques $\mu_a$, $\mu_s'$,
$D = 1/[3(\mu_a+\mu_s')]$, $\delta = \sqrt{D/\mu_a}$, $z_b = 2AD$.
Source ponctuelle isotrope à $\mathbf{r}_0 = (0,0,z_0)$ avec $z_0 = 1/\mu_s'$.

L'équation de diffusion stationnaire est :

$$-D\,\nabla^2\Phi(\mathbf{r}) + \mu_a\,\Phi(\mathbf{r}) = \delta^{(3)}(\mathbf{r}-\mathbf{r}_0)$$

Fonction de Green 3D (Yukawa)
------------------------------

La solution fondamentale en espace infini est la **fonction de Green de Yukawa** :

.. math::

	G_\infty(\mathbf{r},\mathbf{r}_0) = \frac{1}{4\pi D}\,\frac{e^{-|\mathbf{r}-\mathbf{r}_0|/\delta}}{|\mathbf{r}-\mathbf{r}_0|}

C'est une exponentielle décroissante modulée par une décroissance géométrique en $1/\rho$,
analogue au potentiel de Yukawa en physique des particules.

Solution par la Méthode des Images
------------------------------------

Pour satisfaire $\Phi|_{z=-z_b} = 0$, on place une **source image négative** en
$\mathbf{r}_- = (0,0,-(z_0+2z_b))$, symétrique de $\mathbf{r}_0$ par rapport au
plan $z = -z_b$. La solution complète est :

.. math::

	\boxed{
	\Phi(r,z) = \frac{1}{4\pi D}\left[
	\frac{e^{-\rho_+/\delta}}{\rho_+} - \frac{e^{-\rho_-/\delta}}{\rho_-}
	\right]
	}

avec les distances :

$$\rho_+ = \sqrt{r^2+(z-z_0)^2} \quad\text{(source réelle)}$$
$$\rho_- = \sqrt{r^2+(z+z_0+2z_b)^2} \quad\text{(source image)}$$

*Vérification :* en $z = -z_b$, $\rho_+ = \rho_-$, les deux termes se compensent. ✓

Réflectance de Surface en $z = 0$
-----------------------------------

La **réflectance** (flux sortant en surface par unité de surface) est :

$$R(r) = \left.-D\,\frac{\partial\Phi}{\partial z}\right|_{z=0}$$

En calculant $\partial_z(e^{-\rho/\delta}/\rho) = -(z-z_s)/\rho^2\,(1/\delta+1/\rho)\,e^{-\rho/\delta}$
et en évaluant en $z=0$ :

.. math::

	\boxed{
	R(r) = \frac{1}{4\pi}\left[
	z_0\left(\frac{1}{\delta}+\frac{1}{\rho_+}\right)\frac{e^{-\rho_+/\delta}}{\rho_+^2}
	+ (z_0+2z_b)\left(\frac{1}{\delta}+\frac{1}{\rho_-}\right)\frac{e^{-\rho_-/\delta}}{\rho_-^2}
	\right]
	}

avec $\rho_+ = \sqrt{r^2+z_0^2}$ et $\rho_- = \sqrt{r^2+(z_0+2z_b)^2}$.

Comportements Asymptotiques
----------------------------

**Proche de la source** ($r \to 0$) : la source réelle domine ($\rho_- \gg \rho_+$) :

$$R(r) \xrightarrow{r\to 0} \frac{z_0}{4\pi}\left(\frac{1}{\delta}+\frac{1}{\rho_+}\right)\frac{e^{-\rho_+/\delta}}{\rho_+^2}$$

**Loin de la source** ($r \gg \delta$) : les deux sources contribuent et la décroissance
est dominée par l'exponentielle. Un ajustement semi-logarithmique de $r^2 R(r)$ donne
directement $\delta$, puis $\mu_a$ et $\mu_s'$.

Réponse Impulsionnelle (TPSF)
------------------------------

Pour une source ponctuelle impulsionnelle $\delta(t)$, la fluence temporelle est :

$$\Phi(r,z,t) = \frac{c}{(4\pi Dct)^{3/2}}\,e^{-\mu_a ct}
\left[e^{-\rho_+^2/(4Dct)} - e^{-\rho_-^2/(4Dct)}\right]$$

La réflectance temporelle (TPSF) en $z = 0$ :

$$R(r,t) = \frac{c}{2(4\pi Dc)^{3/2}}\,t^{-5/2}\,e^{-\mu_a ct}
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
