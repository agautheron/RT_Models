DA 1D — Méthode des Dipôles avec Fluorescence
==============================================

Introduction
------------

On étend ici la résolution 1D par dipôles au cas **fluorescent**. Le système couplé
(voir :doc:`../base/02_fluorescence_etr`) se réduit, dans l'approximation de diffusion 1D,
à deux EDO en $z$ reliées par un terme source. Le couplage est unidirectionnel :
on résout d'abord le champ d'excitation $\Phi_x(z)$, dont la solution sert de terme
source pour le champ d'émission $\Phi_m(z)$.

Terme Source et Système d'Équations 1D
----------------------------------------

La source d'excitation est un faisceau collimaté d'irradiance $F_0$ s'atténuant
selon la loi de Beer-Lambert :

$$S_x(z) = F_0\,\mu_{sx}'\,e^{-\mu_{tx} z}$$

avec $\mu_{tx} = \mu_{ax}^\text{tot} + \mu_{sx}'$ le coefficient de transport total
à $\lambda_x$, et $\mu_{ax}^\text{tot} = \mu_{ax} + \mu_{af}$.

**Excitation :**

$$-D_x\,\frac{d^2\Phi_x}{dz^2} + \mu_{ax}^\text{tot}\,\Phi_x = F_0\,\mu_{sx}'\,e^{-\mu_{tx} z}$$

avec $D_x = 1/[3\,\mu_{tx}]$.

**Émission (CW) :**

$$-D_m\,\frac{d^2\Phi_m}{dz^2} + \mu_{am}\,\Phi_m
= \eta\,\mu_{af}\!\left[\Phi_x(z) + F_0\,e^{-\mu_{tx} z}\right]$$

avec $D_m = 1/[3(\mu_{am}+\mu_{sm}')]$ et les conditions aux limites extrapolées
$\Phi_x(-z_{bx}) = 0$ et $\Phi_m(-z_{bm}) = 0$.

Le terme $F_0\,e^{-\mu_{tx} z}$ représente la contribution **balistique directe** :
les photons non encore diffusés sont absorbés par le fluorophore et contribuent
à l'émission. Le terme $\Phi_x(z)$ est la contribution des photons diffus.

Résolution — Champ d'Excitation
---------------------------------

La solution pour $\Phi_x$ est celle de l'équation de diffusion avec terme source
exponentiel (voir :doc:`04_da_1d_dipoles_sans_fluo`) :

.. math::

	\Phi_x(z) = \underbrace{\frac{F_0\,\mu_{sx}'}{\mu_{ax}^\text{tot} - D_x\mu_{tx}^2}\,e^{-\mu_{tx} z}}_{\text{terme balistique amorti}}
	+ \underbrace{\frac{\delta_x}{2D_x}\left[C_{x+}\,e^{-|z-z_{0x}|/\delta_x}
	- C_{x-}\,e^{-|z+z_{0x}+2z_{bx}|/\delta_x}\right]}_{\text{dipôle diffus + image}}

avec $z_{0x} = 1/\mu_{tx}$, $\delta_x = \sqrt{D_x/\mu_{ax}^\text{tot}}$
et les constantes $C_{x\pm}$ fixées par $\Phi_x(-z_{bx}) = 0$.

Résolution — Champ d'Émission
--------------------------------

Le membre de droite de l'équation d'émission
$\eta\,\mu_{af}\!\left[\Phi_x(z) + F_0\,e^{-\mu_{tx} z}\right]$
est une combinaison de trois types de termes exponentiels :
$e^{-\mu_{tx} z}$ (terme balistique direct + contribution balistique de $\Phi_x$)
et $e^{-|z-z_s|/\delta_x}$ (termes diffus de $\Phi_x$).
On cherche la solution particulière pour chaque exponentielle par la **méthode de Green 1D**.

**Solution particulière pour le terme balistique total**
$\eta\,\mu_{af}(A_0 + F_0)\,e^{-\mu_{tx} z}$
où $A_0 = F_0\,\mu_{sx}'/(\mu_{ax}^\text{tot} - D_x\mu_{tx}^2)$
est le coefficient du terme $e^{-\mu_{tx}z}$ dans $\Phi_x$ :

$$\Phi_{m,\text{balist}}^\text{part}(z)
= \frac{\eta\,\mu_{af}\,(A_0 + F_0)}{\mu_{am} - D_m\mu_{tx}^2}\,e^{-\mu_{tx} z}$$

**Solution particulière pour un terme diffus** $A_s\,e^{-|z-z_s|/\delta_x}$
($\delta_x \neq \delta_m$) :

.. math::

	\Phi_{m,\text{diff}}^\text{part}(z) = \frac{\eta\,\mu_{af}\,A_s\,\delta_m^2/D_m}{1-(\delta_m/\delta_x)^2}\,e^{-|z-z_s|/\delta_x}

.. solution::

   On injecte $\Phi^\text{part} = B\,e^{-|z-z_s|/\delta_x}$ dans l'EDO d'émission :

   $$-D_m\,\frac{d^2}{dz^2}\left(B\,e^{-z/\delta_x}\right) + \mu_{am}\,B\,e^{-z/\delta_x}
   = B\left(-\frac{D_m}{\delta_x^2} + \mu_{am}\right)e^{-z/\delta_x}
   = B\,\frac{\mu_{am}\delta_x^2 - D_m}{\delta_x^2}\,e^{-z/\delta_x}$$

   En égalisant au terme source $\eta\,\mu_{af}\,A_s\,e^{-z/\delta_x}$ :

   $$B = \frac{\eta\,\mu_{af}\,A_s\,\delta_x^2}{\mu_{am}\delta_x^2 - D_m}
   = \frac{\eta\,\mu_{af}\,A_s\,\delta_m^2/D_m}{1-(\delta_m/\delta_x)^2}$$

   car $D_m/\delta_m^2 = \mu_{am}$.

La solution complète est la somme des solutions particulières plus la solution
homogène de l'EDO d'émission :

.. math::

	\boxed{\Phi_m(z) = \Phi_m^\text{part}(z) + C_m\,e^{-z/\delta_m}}

$$C_m = -\Phi_m^\text{part}(-z_{bm})\,e^{z_{bm}/\delta_m}$$

Cas Particulier $\delta_x = \delta_m$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Quand les longueurs de diffusion d'excitation et d'émission coïncident, la solution
particulière devient résonnante et prend la forme $z\,e^{-z/\delta}$ :

.. math::

	\Phi_m^\text{part}(z) = \frac{\eta\,\mu_{af}}{2D_m}\,\frac{z}{\delta}\,e^{-|z-z_0|/\delta}

Cette situation est rare en pratique ($\lambda_x \neq \lambda_m$ implique généralement
$\mu_a(\lambda_x) \neq \mu_a(\lambda_m)$).

Flux d'Émission en Surface
---------------------------

Le flux d'émission détecté en $z = 0$ est :

$$J_m(0) = -D_m\,\frac{d\Phi_m}{dz}\bigg|_{z=0}$$

Il dépend de $\mu_{af}$, $\eta$, $F_0$, ainsi que des propriétés optiques à chaque
longueur d'onde. C'est la grandeur mesurée en FDOT.

Extension Temporelle
---------------------

En régime temporel, la convolution avec le temps de vie ajoute un terme :

$$\frac{1}{c}\frac{\partial\Phi_m}{\partial t} - D_m\,\frac{\partial^2\Phi_m}{\partial z^2}
+ \mu_{am}\,\Phi_m
= \frac{\eta\,\mu_{af}}{\tau_f}\int_{-\infty}^{t}e^{-(t-t')/\tau_f}
\!\left[\Phi_x(z,t') + F_0\,e^{-\mu_{tx}z}\,\delta(t')\right]dt'$$

Le terme $F_0\,e^{-\mu_{tx}z}\,\delta(t')$ représente l'impulsion balistique à $t=0$.
En domaine fréquentiel ($\omega$), le facteur de déphasage $(1+j\omega\tau_f)^{-1}$
modifie l'amplitude et la phase du terme source, permettant de séparer les
contributions de fluorophores de durées de vie différentes.

.. seealso::

   :doc:`04_da_1d_dipoles_sans_fluo` — cas sans fluorescence dont ce fichier est l'extension.

   :doc:`../base/02_fluorescence_etr` — système d'ETR couplées dont est issu le système de DA.

   :doc:`07_da_2d_dipoles_avec_fluo` — extension au cas 2D.
