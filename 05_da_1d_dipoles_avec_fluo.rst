DA 1D — Méthode des Dipôles avec Fluorescence
==============================================

Introduction
------------

On étend ici la résolution 1D par dipôles au cas **fluorescent**. Le système couplé
(voir :doc:`02_fluorescence_etr`) se réduit, dans l'approximation de diffusion 1D,
à deux EDO en $z$ reliées par un terme source. Le couplage est unidirectionnel :
on résout d'abord le champ d'excitation $\Phi_x(z)$, dont la solution sert de terme
source pour le champ d'émission $\Phi_m(z)$.

Système d'Équations 1D
------------------------

**Excitation :**

$$-D_x\,\frac{d^2\Phi_x}{dz^2} + \mu_{ax}^\text{tot}\,\Phi_x = \delta(z-z_0)$$

avec $\mu_{ax}^\text{tot} = \mu_{ax} + \mu_{af}$ et $D_x = 1/[3(\mu_{ax}^\text{tot}+\mu_{sx}')]$.

**Émission (CW) :**

$$-D_m\,\frac{d^2\Phi_m}{dz^2} + \mu_{am}\,\Phi_m = \eta\,\mu_{af}\,\Phi_x(z)$$

avec $D_m = 1/[3(\mu_{am}+\mu_{sm}')]$ et les conditions aux limites extrapolées
$\Phi_x(-z_{bx}) = 0$ et $\Phi_m(-z_{bm}) = 0$.

Résolution — Champ d'Excitation
---------------------------------

La solution pour $\Phi_x$ est identique au cas sans fluorescence (voir :doc:`04_da_1d_dipoles_sans_fluo`),
avec la longueur de diffusion $\delta_x = \sqrt{D_x/\mu_{ax}^\text{tot}}$ :

.. math::

	\Phi_x(z) = \frac{\delta_x}{2D_x}
	\left[e^{-|z-z_0|/\delta_x} - e^{-(z+z_0+2z_{bx})/\delta_x}\right]

Résolution — Champ d'Émission
--------------------------------

Le membre de droite de l'équation d'émission est une combinaison de deux termes
exponentiels issus de $\Phi_x(z)$. On cherche la solution particulière de l'équation
d'émission pour chaque exponentielle :math:`e^{-\alpha|z-z_s|}`, en utilisant la
**variation des constantes** ou la **méthode de Green 1D**.

Pour un terme source de la forme :math:`f(z) = A_s\,e^{-|z-z_s|/\delta_x}`, la solution
particulière de $-D_m\,d^2\Phi/dz^2 + \mu_{am}\,\Phi = f(z)$ est, hors singularité
($\delta_x \neq \delta_m$) :

.. math::

	\Phi_m^\text{part}(z) = \frac{A_s\,\delta_m^2}{D_m}\,\frac{1}{1-(\delta_m/\delta_x)^2}\,e^{-|z-z_s|/\delta_x}

La solution complète est la somme des solutions particulières (source réelle et source
image) **plus** la solution homogène de la 1D d'émission :
:math:`\Phi_m^\text{hom} = C_+\,e^{z/\delta_m} + C_-\,e^{-z/\delta_m}`.
Les constantes $C_\pm$ sont fixées par la condition aux limites $\Phi_m(-z_{bm}) = 0$
et la condition de croissance bornée ($C_+ = 0$ si $z \to \infty$) :

$$\boxed{\Phi_m(z) = \Phi_m^\text{part}(z) + C_-\,e^{-z/\delta_m}}$$

$$C_- = -\Phi_m^\text{part}(-z_{bm})\,e^{z_{bm}/\delta_m}$$

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

Il dépend de $\mu_{af}$, $\eta$, ainsi que des propriétés optiques à chaque longueur
d'onde. C'est la grandeur mesurée en FDOT.

Extension Temporelle
---------------------

En régime temporel, la convolution avec le temps de vie ajoute un terme :

$$\frac{1}{c}\frac{\partial\Phi_m}{\partial t} - D_m\,\frac{\partial^2\Phi_m}{\partial z^2}
+ \mu_{am}\,\Phi_m
= \frac{\eta\,\mu_{af}}{\tau_f}\int_{-\infty}^{t}e^{-(t-t')/\tau_f}\,\Phi_x(z,t')\,dt'$$

En domaine fréquentiel ($\omega$), le facteur de déphasage $(1+j\omega\tau_f)^{-1}$
modifie l'amplitude et la phase du terme source, permettant de séparer les
contributions de fluorophores de durées de vie différentes.

.. seealso::

   :doc:`04_da_1d_dipoles_sans_fluo` — cas sans fluorescence dont ce fichier est l'extension.

   :doc:`02_fluorescence_etr` — système d'ETR couplées dont est issu le système de DA.

   :doc:`07_da_2d_dipoles_avec_fluo` — extension au cas 2D.
