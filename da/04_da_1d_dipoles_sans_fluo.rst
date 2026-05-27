DA 1D — Méthode des Dipôles sans Fluorescence
==============================================

Introduction
------------

On considère ici le cas **1D** : le milieu est un plan infini homogène et la fluence
ne dépend que de la profondeur $z$. L'équation de diffusion se réduit à une EDO
en $z$, dont la solution par la méthode des images (dipôles) est particulièrement
simple et pédagogique avant de passer au cas 2D (voir :doc:`06_da_2d_dipoles_sans_fluo`).

Géométrie et Terme Source
--------------------------

Milieu semi-infini occupant $z \ge 0$. La source est un faisceau **collimaté**
d'irradiance $F_0$ (W mm$^{-2}$) entrant en $z = 0$ et s'atténuant selon la loi
de Beer-Lambert :

$$S(z) = F_0\,\mu_s'\,e^{-\mu_t z}$$

Le facteur $\mu_s'$ traduit la conversion des photons balistiques en photons diffus :
seule la fraction diffusée alimente la fluence diffuse. La profondeur caractéristique
d'injection est $z_0 = 1/\mu_t$.

Équation Gouvernante
---------------------

L'équation de diffusion stationnaire 1D est :

$$-D\,\frac{d^2\Phi}{dz^2} + \mu_a\,\Phi = F_0\,\mu_s'\,e^{-\mu_t z}$$

Les paramètres sont $D = 1/[3(\mu_a+\mu_s')]$, $\delta = \sqrt{D/\mu_a}$,
$z_b = 2AD$ (distance extrapolée), avec la condition aux limites $\Phi(-z_b) = 0$.

Fonction de Green 1D
---------------------

La solution fondamentale de $-D\,d^2G/dz^2 + \mu_a\,G = \delta(z-z_s)$ est :

.. math::

	G_\infty(z,z_s) = \frac{1}{2\sqrt{D\mu_a}}\,e^{-|z-z_s|/\delta}
	= \frac{\delta}{2D}\,e^{-|z-z_s|/\delta}

Solution par la Méthode des Dipôles
-------------------------------------

On cherche la solution de l'équation non-homogène. La solution particulière pour
le terme source $F_0\,\mu_s'\,e^{-\mu_t z}$ est :

$$\Phi_\text{part}(z) = \frac{F_0\,\mu_s'\,\delta^2/D}{1-(\delta\,\mu_t)^2}\,e^{-\mu_t z}
= \frac{F_0\,\mu_s'}{D(\mu_t^2 - \mu_a/D)}\,e^{-\mu_t z}
= \frac{F_0\,\mu_s'}{D\mu_t^2 - \mu_a}\,e^{-\mu_t z}$$

.. solution::

   On injecte $\Phi_\text{part} = A\,e^{-\mu_t z}$ dans l'équation :

   $$-D(-\mu_t)^2 A\,e^{-\mu_t z} + \mu_a A\,e^{-\mu_t z} = F_0\,\mu_s'\,e^{-\mu_t z}$$

   $$A(\mu_a - D\mu_t^2) = F_0\,\mu_s'
   \implies A = \frac{F_0\,\mu_s'}{\mu_a - D\mu_t^2}$$

   Comme $\mu_a - D\mu_t^2 = \mu_a - \mu_t^2/[3(\mu_a+\mu_s')] < 0$ en général
   (car $\mu_t \gg \mu_a$), on écrit $A = -F_0\,\mu_s'/(D\mu_t^2-\mu_a)$.

Pour satisfaire la condition $\Phi(-z_b)=0$, on ajoute la solution homogène
$C\,e^{-z/\delta}$ (terme décroissant, borné pour $z\to\infty$), et une
**source image négative** en $z_- = -(z_0+2z_b)$ via la fonction de Green :

.. math::

	\boxed{\Phi(z) = \frac{F_0\,\mu_s'}{\mu_a - D\mu_t^2}\,e^{-\mu_t z}
	+ \frac{\delta}{2D}\left[C_+\,e^{-|z-z_0|/\delta} - C_-\,e^{-|z+z_0+2z_b|/\delta}\right]}

avec $z_0 = 1/\mu_t$ et les constantes $C_\pm$ fixées par $\Phi(-z_b)=0$ et la
continuité de $d\Phi/dz$ en $z=0$ :

$$C_- = C_+, \qquad
C_+ = -\frac{F_0\,\mu_s'}{\mu_a - D\mu_t^2}\,\frac{e^{\mu_t z_b}}{\cosh(z_b/\delta)}$$

Flux en Surface $z = 0$
------------------------

Le flux sortant en surface est $J(0) = -D\,d\Phi/dz|_{z=0}$ :

.. math::

	\boxed{J(0) = F_0\,\mu_s'\left[
	\frac{D\mu_t}{\mu_a - D\mu_t^2}
	+ \frac{1}{2}\left(e^{-z_0/\delta} - e^{-(z_0+2z_b)/\delta}\right)
	+ \frac{1}{2}C_+\left(e^{-z_0/\delta} + e^{-(z_0+2z_b)/\delta}\right)
	\right]}

Le premier terme est la contribution balistique directe ; les suivants
sont les contributions diffuses (dipôle réel et image).

Cas Temporel — Impulsion de Dirac
-----------------------------------

Pour une source impulsionnelle $F_0\,\delta(t)\,e^{-\mu_t z}$, la fluence dépendante
du temps est obtenue par transformée de Laplace inverse avec $\mu_a \to \mu_a + s/c$ :

$$\Phi(z,t) = \frac{c}{\sqrt{4\pi Dct}}\,e^{-\mu_a ct}
\left[e^{-(z-z_0)^2/(4Dct)} - e^{-(z+z_0+2z_b)^2/(4Dct)}\right]$$

modifiée par la contribution du terme source étendu $e^{-\mu_t z}$.

Régime Fréquentiel
-------------------

Pour une source modulée $e^{-j\omega t}$, on substitue
$\mu_a \leftarrow \mu_a + j\omega/c$ et $\delta \leftarrow 1/k(\omega)$
avec $k = \sqrt{(\mu_a+j\omega/c)/D}$. De même, $\mu_t$ est inchangé (coefficient
de transport total, indépendant de la modulation). La solution garde la même forme
avec les paramètres complexes.

.. seealso::

   :doc:`03_approximation_diffusion` — équation de diffusion dont cette section est une résolution.

   :doc:`05_da_1d_dipoles_avec_fluo` — extension du même formalisme à la fluorescence.

   :doc:`06_da_2d_dipoles_sans_fluo` — cas 2D (dépendance en $r$ et $z$).
