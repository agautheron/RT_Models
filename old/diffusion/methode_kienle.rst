Résolution par la Méthode de Kienle
=====================================

Présentation de la Méthode
--------------------------

La méthode de Kienle (1997) fournit une **solution analytique** de l'équation de
diffusion radiative dans un milieu semi-infini, homogène, avec une interface plane.
Elle est particulièrement utilisée en **tomographie optique diffuse** (DOT) et en
spectroscopie des tissus biologiques, où le milieu diffusant (tissu) est éclairé en
surface par une source ponctuelle.

La solution repose sur deux ingrédients :

1. L'**approximation de diffusion** (voir :doc:`approximation_diffusion`), valide en
   profondeur optique élevée.
2. La **condition aux limites extrapolée** (*extrapolated boundary condition*, EBC),
   qui tient compte du désaccord d'indice de réfraction à l'interface air–tissu.

Géométrie et Notations
-----------------------

On considère un milieu semi-infini occupant le demi-espace :math:`z > 0`.

.. list-table::
   :header-rows: 1
   :widths: 20 80

   * - Symbole
     - Définition
   * - :math:`\mu_a`
     - Coefficient d'absorption (cm\ :sup:`−1`)
   * - :math:`\mu_s'`
     - Coefficient de diffusion réduit (cm\ :sup:`−1`), :math:`\mu_s' = \mu_s(1-g)`
   * - :math:`g`
     - Facteur d'anisotropie de la diffusion (cosinus moyen)
   * - :math:`D`
     - Coefficient de diffusion, :math:`D = \frac{1}{3(\mu_a + \mu_s')}`
   * - :math:`\delta`
     - Longueur de diffusion, :math:`\delta = \sqrt{D/\mu_a}`
   * - :math:`n`
     - Indice de réfraction relatif milieu/air
   * - :math:`z_b`
     - Distance extrapolée de la frontière
   * - :math:`r`
     - Distance radiale à la source en surface
   * - :math:`\rho`
     - Distance 3D entre le point d'observation et une source image

La source ponctuelle isotrope est placée à la profondeur :math:`z_0 = 1/\mu_s'`
(profondeur de première diffusion).

Condition aux Limites Extrapolée
---------------------------------

La condition aux limites exacte impose la nullité du flux entrant à l'interface. Dans
l'approximation de diffusion, on la remplace par la **condition de Dirichlet extrapolée**
(Robin → Dirichlet) :

.. math::

   \Phi(\mathbf{r})\big|_{z = -z_b} = 0

où la distance extrapolée est :

.. math::

   z_b = 2\,A\,D

Le coefficient :math:`A` tient compte de la réflexion interne due au saut d'indice.
Kienle et Patterson (1997) donnent l'expression :

.. math::

   A = \frac{1 + R_\phi}{1 - R_J}

avec les moments de la réflectance de Fresnel :

.. math::

   R_\phi = \int_0^{\pi/2} 2\sin\theta\cos\theta\, R_F(\theta)\, d\theta

.. math::

   R_J    = \int_0^{\pi/2} 3\sin\theta\cos^2\!\theta\, R_F(\theta)\, d\theta

:math:`R_F(\theta)` est la réflectivité de Fresnel en intensité pour un angle
d'incidence :math:`\theta`. Pour :math:`n = 1` (pas de désaccord d'indice), :math:`A = 1`
et :math:`z_b = 2D`.

Équation de Diffusion et Solution par la Méthode des Images
-------------------------------------------------------------

Équation gouvernante
~~~~~~~~~~~~~~~~~~~~

En régime stationnaire, la fluence :math:`\Phi(\mathbf{r})` (W cm\ :sup:`−2`) satisfait :

.. math::

   -D\,\nabla^2 \Phi(\mathbf{r}) + \mu_a\,\Phi(\mathbf{r}) = S(\mathbf{r})

Pour une source ponctuelle unitaire en :math:`(0, 0, z_0)` :

.. math::

   S(\mathbf{r}) = \delta(\mathbf{r} - z_0\,\hat{z})

Solution de Green en espace infini
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La solution fondamentale (fonction de Green) de l'équation de Helmholtz-diffusion en
espace illimité est :

.. math::

   G(\mathbf{r},\mathbf{r}') = \frac{1}{4\pi D}
   \frac{e^{-|\mathbf{r}-\mathbf{r}'|/\delta}}{|\mathbf{r}-\mathbf{r}'|}

Méthode des images
~~~~~~~~~~~~~~~~~~~

Pour satisfaire la condition aux limites :math:`\Phi = 0` au plan :math:`z = -z_b`,
on introduit une **source image négative** en position miroir
:math:`(0, 0, -(z_0 + 2z_b))`.

La solution complète est :

.. math::

   \boxed{
   \Phi(r, z) = \frac{1}{4\pi D}
   \left(
     \frac{e^{-\rho_1/\delta}}{\rho_1}
   - \frac{e^{-\rho_2/\delta}}{\rho_2}
   \right)
   }

avec les distances :

.. math::

   \rho_1 = \sqrt{r^2 + (z - z_0)^2}
   \qquad \text{(source réelle)}

.. math::

   \rho_2 = \sqrt{r^2 + (z + z_0 + 2z_b)^2}
   \qquad \text{(source image)}

Réflectance de Surface
-----------------------

La grandeur mesurable en pratique est la **réflectance** :math:`R(r)`, c'est-à-dire
le flux sortant à la surface :math:`z = 0` par unité de surface :

.. math::

   R(r) = \left.\left(-D\,\frac{\partial \Phi}{\partial z}\right)\right|_{z=0}

En développant la dérivée de la solution de Kienle :

.. math::

   \boxed{
   R(r) = \frac{1}{4\pi}
   \left[
     z_0\left(\frac{1}{\rho_1} + \frac{1}{\delta}\right)
     \frac{e^{-\rho_1/\delta}}{\rho_1^2}
   + (z_0 + 2z_b)\left(\frac{1}{\rho_2} + \frac{1}{\delta}\right)
     \frac{e^{-\rho_2/\delta}}{\rho_2^2}
   \right]
   }

avec ici :math:`\rho_1 = \sqrt{r^2 + z_0^2}` et
:math:`\rho_2 = \sqrt{r^2 + (z_0 + 2z_b)^2}`.

.. note::

   Dans la limite :math:`r \gg \delta`, le terme en :math:`\rho_2` devient dominant
   et la réflectance décroît comme :math:`r^{-2} e^{-r/\delta}`, ce qui permet
   d'extraire directement :math:`\delta`, donc :math:`\mu_a` et :math:`\mu_s'`,
   par ajustement de courbe.

Extension Temporelle : Domaine Temporel
-----------------------------------------

Kienle et Patterson ont également dérivé la solution **résolue en temps** pour une
impulsion de Dirac :math:`S \propto \delta(t)`. La fluence dépendante du temps est :

.. math::

   \Phi(r, z, t) = c\,(4\pi Dc t)^{-3/2}\, e^{-\mu_a c t}
   \left[
     e^{-\rho_1^2/(4Dct)}
   - e^{-\rho_2^2/(4Dct)}
   \right]

La réflectance temporelle s'obtient par :

.. math::

   R(r, t) = \left.\left(-D\,\frac{\partial \Phi}{\partial z}\right)\right|_{z=0}

soit explicitement :

.. math::

   R(r,t) = \frac{c}{2}\,(4\pi Dc)^{-3/2}\,t^{-5/2}\,e^{-\mu_a c t}
   \left[
     z_0\,e^{-\rho_1^2/(4Dct)}
   + (z_0+2z_b)\,e^{-\rho_2^2/(4Dct)}
   \right]

.. list-table:: Domaine fréquentiel vs temporel
   :header-rows: 1
   :widths: 25 37 38

   * - Grandeur
     - Domaine continu (CW)
     - Domaine temporel (TD)
   * - Source
     - Puissance constante
     - Impulsion ultrabrève (ps)
   * - Mesure
     - :math:`R(r)` (intensité)
     - :math:`R(r, t)` (TPSF)
   * - Sensibilité à :math:`\mu_a`
     - Modérée
     - Élevée (queue temporelle)
   * - Sensibilité à :math:`\mu_s'`
     - Modérée
     - Élevée (sommet de la TPSF)
   * - Complexité expérimentale
     - Faible
     - Élevée (laser ps, TCSPC)

(TPSF : *Temporal Point Spread Function*)

Procédure d'Extraction des Paramètres Optiques
------------------------------------------------

En pratique, l'ajustement de la courbe mesurée sur la solution de Kienle suit les
étapes suivantes :

1. **Mesure** de :math:`R(r)` (CW) ou :math:`R(r,t)` (TD) sur plusieurs distances
   source–détecteur :math:`r`.

2. **Initialisation** des paramètres :math:`(\mu_a^{(0)},\, \mu_s^{\prime(0)})` à
   partir d'ordres de grandeur connus (ex. tissu biologique : :math:`\mu_a \sim 0{,}1`
   cm\ :sup:`−1`, :math:`\mu_s' \sim 10` cm\ :sup:`−1`).

3. **Ajustement non linéaire** (Levenberg–Marquardt) minimisant :

   .. math::

      \chi^2 = \sum_i \frac{\left[R_{\rm mes}(r_i) - R_{\rm Kienle}(r_i;\,\mu_a,\mu_s')\right]^2}
                           {\sigma_i^2}

4. **Vérification** de la validité : s'assurer que :math:`\mu_s' \gg \mu_a` (diffusion
   dominante) et que :math:`r \gtrsim 3\delta` (régime diffusif établi).

Limites de la Méthode
---------------------

.. warning::

   La méthode de Kienle repose sur l'approximation de diffusion et ses hypothèses
   associées. Elle est mise en défaut dans les situations suivantes :

- **Milieu hétérogène** : la solution analytique suppose un milieu parfaitement homogène.
- **Faibles distances source–détecteur** (:math:`r \lesssim \ell^* = 1/\mu_s'`) :
  le régime balistique ou quasi-balistique n'est pas décrit par la diffusion.
- **Absorption élevée** (:math:`\mu_a \gtrsim \mu_s'`) : l'approximation :math:`P_1`
  (Eddington) n'est plus valide.
- **Milieu borné** (couche fine) : la géométrie semi-infinie n'est plus appropriée ;
  des solutions multi-couches existent (Kienle et al., 1998).

Récapitulatif des Formules Clés
--------------------------------

.. list-table::
   :header-rows: 0
   :widths: 40 60

   * - Coefficient de diffusion
     - :math:`D = \dfrac{1}{3(\mu_a + \mu_s')}`
   * - Longueur de diffusion
     - :math:`\delta = \sqrt{D/\mu_a}`
   * - Profondeur de source
     - :math:`z_0 = 1/\mu_s'`
   * - Distance extrapolée
     - :math:`z_b = 2AD`
   * - Source réelle (distance)
     - :math:`\rho_1 = \sqrt{r^2 + z_0^2}`
   * - Source image (distance)
     - :math:`\rho_2 = \sqrt{r^2 + (z_0+2z_b)^2}`
   * - Fluence (CW)
     - :math:`\Phi = \frac{1}{4\pi D}\!\left(\frac{e^{-\rho_1/\delta}}{\rho_1} - \frac{e^{-\rho_2/\delta}}{\rho_2}\right)`
   * - Réflectance (CW)
     - voir expression développée ci-dessus

Références
----------

- Kienle, A. & Patterson, M. S. (1997). *Improved solutions of the steady-state and
  the time-resolved diffusion equations for reflectance from a semi-infinite turbid
  medium.* Journal of the Optical Society of America A, **14**(1), 246–254.

- Kienle, A., Lilge, L., Patterson, M. S., Hibst, R., Steiner, R. & Wilson, B. C.
  (1996). *Spatially resolved absolute diffuse reflectance measurements for
  noninvasive determination of the optical scattering and absorption coefficients of
  biological tissue.* Applied Optics, **35**(13), 2304–2314.

- Patterson, M. S., Chance, B. & Wilson, B. C. (1989). *Time resolved reflectance
  and transmittance for the noninvasive measurement of tissue optical properties.*
  Applied Optics, **28**(12), 2331–2336.

.. seealso::

   :doc:`approximation_diffusion` — dérivation de l'équation de diffusion et
   conditions de validité.

   :doc:`transfert_radiatif` — équation du transfert radiatif complète dont
   l'approximation de diffusion est issue.
