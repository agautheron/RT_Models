DA 1D — Méthode des Dipôles sans Fluorescence
==============================================

Introduction
------------

On considère ici le cas **1D** : le milieu est un plan infini homogène et la fluence
ne dépend que de la profondeur $z$. L'équation de diffusion se réduit à une EDO
en $z$, dont la solution par la méthode des images (dipôles) est particulièrement
simple et pédagogique avant de passer au cas 2D (voir :doc:`06_da_2d_dipoles_sans_fluo`).

Géométrie et Équation Gouvernante
-----------------------------------

Milieu semi-infini occupant $z \ge 0$, source plane isotrope à la profondeur
$z_0 = 1/\mu_s'$. En géométrie 1D (invariance dans le plan transverse), l'équation
de diffusion stationnaire est :

$$-D\,\frac{d^2\Phi}{dz^2} + \mu_a\,\Phi = \delta(z-z_0)$$

Les paramètres sont $D = 1/[3(\mu_a+\mu_s')]$, $\delta = \sqrt{D/\mu_a}$,
$z_b = 2AD$ (distance extrapolée) et la condition aux limites $\Phi(-z_b) = 0$.

Fonction de Green 1D
---------------------

La solution fondamentale de $-D\,d^2G/dz^2 + \mu_a\,G = \delta(z-z_s)$ en demi-espace
infini est :

.. math::

	G_\infty(z,z_s) = \frac{1}{2\sqrt{D\mu_a}}\,e^{-|z-z_s|/\delta}
	= \frac{\delta}{2D}\,e^{-|z-z_s|/\delta}

Solution par la Méthode des Images
------------------------------------

Pour satisfaire $\Phi(-z_b)=0$, on ajoute une **source image négative** en
:math:`z_- = -(z_0+2z_b)`, symétrique de $z_0$ par rapport au plan $z=-z_b$ :

.. math::

	\boxed{\Phi(z) = \frac{\delta}{2D}\left[e^{-|z-z_0|/\delta} - e^{-|z+z_0+2z_b|/\delta}\right]}

*Vérification :* en $z = -z_b$, les deux distances valent $z_b+z_0$ ; les termes
se compensent exactement. ✓

Flux en Surface $z = 0$
------------------------

Le flux sortant en surface est $J(0) = -D\,d\Phi/dz|_{z=0}$ :

$$\boxed{J(0) = \frac{1}{2}\left[e^{-z_0/\delta} - e^{-(z_0+2z_b)/\delta}\right]}$$

Ce résultat dépend uniquement du rapport $z_0/\delta = \mu_s'/\sqrt{3\mu_a\mu_t'}$
et de $z_b/\delta$, deux nombres sans dimension qui caractérisent complètement
le régime optique du milieu.

Cas Temporel — Impulsion de Dirac
-----------------------------------

Pour une source impulsionnelle $\delta(t)$, la fluence dépendante du temps est
obtenue par transformée de Laplace inverse ($\mu_a \to \mu_a + j\omega/c \to p/c + \mu_a$).
En espace réel :

$$\Phi(z,t) = \frac{c}{\sqrt{4\pi Dct}}\,e^{-\mu_a ct}
\left[e^{-(z-z_0)^2/(4Dct)} - e^{-(z+z_0+2z_b)^2/(4Dct)}\right]$$

La décroissance exponentielle $e^{-\mu_a ct}$ aux grands temps permet d'extraire
$\mu_a$ directement depuis la pente de la queue de la réponse impulsionnelle.

Régime Fréquentiel
-------------------

Pour une source modulée $e^{-j\omega t}$, on substitue
$\mu_a \leftarrow \mu_a + j\omega/c$ et $\delta \leftarrow \delta(\omega) = 1/k(\omega)$
avec $k = \sqrt{(\mu_a+j\omega/c)/D}$. La solution garde la même forme :

$$\tilde\Phi(z) = \frac{1}{2Dk(\omega)}
\left[e^{-k|z-z_0|} - e^{-k(z+z_0+2z_b)}\right]$$

dont l'amplitude et la phase donnent accès à $\mu_a$ et $\mu_s'$.

.. seealso::

   :doc:`03_approximation_diffusion` — équation de diffusion dont cette section est une résolution.

   :doc:`05_da_1d_dipoles_avec_fluo` — extension du même formalisme à la fluorescence.

   :doc:`06_da_2d_dipoles_sans_fluo` — cas 2D (dépendance en $r$ et $z$).
