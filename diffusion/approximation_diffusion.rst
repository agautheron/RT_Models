L'Approximation de Diffusion
=============================

.. contents:: Table des matières
   :depth: 3
   :local:

Vue d'ensemble
--------------

Dans la limite **optiquement épaisse** (:math:`\tau \gg 1`), les photons subissent de
nombreuses diffusions avant de parcourir une distance significative. Le champ de
rayonnement devient presque isotrope, et la dépendance angulaire complète de l'intensité
spécifique peut être réduite à une **équation de diffusion** beaucoup plus simple pour
la densité d'énergie. C'est l'**approximation de diffusion** (appelée aussi approximation
d'Eddington dans sa forme la plus simple).

Intuition Physique
------------------

Imaginons un photon au cœur d'un nuage optiquement épais. Il est diffusé si souvent
qu'il perd toute mémoire de sa direction initiale après quelques libres parcours moyens.
Son déplacement net ressemble à une **marche aléatoire** : après :math:`N` diffusions
de libre parcours moyen :math:`\ell`, le déplacement quadratique moyen est
:math:`\sqrt{N}\,\ell`. L'énergie se propage non pas balistiquement mais de manière
**diffusive**, avec un coefficient de diffusion effectif :

.. math::

   D = \frac{c\,\ell}{3} = \frac{c}{3\,\chi}

où :math:`\chi = \kappa + \sigma` est l'opacité totale. Le facteur 3 provient des trois
dimensions spatiales de la marche aléatoire.

Dérivation
----------

Fermeture d'Eddington
~~~~~~~~~~~~~~~~~~~~~

On part des deux équations de moments (voir :doc:`transfert_radiatif`) :

.. math::

   \frac{\partial E}{\partial t} + \nabla \cdot \mathbf{F}
   = c\,\kappa\,(4\pi B - c\,E)

.. math::

   \frac{1}{c^2}\frac{\partial \mathbf{F}}{\partial t} + \nabla \cdot \mathbf{P}
   = -\chi\, \frac{\mathbf{F}}{c}

(intégrées en fréquence pour simplifier, les indices :math:`\nu` sont omis.)

Ces équations sont exactes mais non fermées, car le tenseur de pression radiative
:math:`\mathbf{P}` fait intervenir le moment d'ordre 2 de :math:`I`. La **fermeture
d'Eddington** suppose que le champ est presque isotrope et ferme la hiérarchie par :

.. math::

   \mathbf{P} = \frac{E}{3}\,\mathbf{I}
   \quad\Longleftrightarrow\quad
   P_{ij} = \frac{1}{3}\,E\,\delta_{ij}

Cette relation est exacte pour un champ parfaitement isotrope. Dans un milieu
optiquement épais, l'anisotropie est faible (d'ordre :math:`1/\tau`), et l'erreur
introduite est d'ordre :math:`O(\tau^{-2})`.

Relation flux–gradient
~~~~~~~~~~~~~~~~~~~~~~

En régime stationnaire et sans terme d'inertie, l'équation du flux devient :

.. math::

   \nabla \cdot \mathbf{P} = -\frac{\chi}{c}\,\mathbf{F}
   \quad\Longrightarrow\quad
   \frac{1}{3}\,\nabla E = -\frac{\chi}{c}\,\mathbf{F}

En isolant :math:`\mathbf{F}` :

.. math::

   \boxed{\mathbf{F} = -D\,\nabla E, \qquad D = \frac{c}{3\,\chi}}

Il s'agit de la **loi de Fick** pour le rayonnement : le flux est proportionnel au
gradient de densité d'énergie et orienté dans le sens descendant de ce gradient. Le
rayonnement se comporte exactement comme un matériau conducteur de chaleur, avec une
diffusivité :math:`D`.

L'équation de diffusion radiative
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En substituant la loi de Fick dans l'équation d'énergie, et en supposant l'équilibre
thermodynamique local (ETL) de sorte que :math:`E_{\rm eq} = aT^4`, on obtient :

.. math::

   \frac{\partial E}{\partial t}
   - \nabla \cdot \left(D\,\nabla E\right)
   = c\,\kappa\,\left(a T^4 - E\right)

Dans le cas purement absorbant en ETL et en opacité grise, cela se réduit à l'**équation
de diffusion radiative** classique :

.. math::

   \frac{\partial E}{\partial t}
   = \nabla \cdot \left(\frac{c}{3\,\kappa}\,\nabla E\right)

qui est une EDP parabolique de même forme que l'équation de la chaleur.

Opacité Effective et Moyenne de Rosseland
-----------------------------------------

Lorsque le milieu est dépendant en fréquence, l'opacité moyennée en fréquence adaptée
à la diffusion est l'**opacité moyenne de Rosseland** :math:`\kappa_R` :

.. math::

   \frac{1}{\kappa_R} =
   \frac{\displaystyle\int_0^\infty \frac{1}{\chi_\nu}\,
         \frac{\partial B_\nu}{\partial T}\,d\nu}
        {\displaystyle\int_0^\infty
         \frac{\partial B_\nu}{\partial T}\,d\nu}

Propriétés clés :

- C'est une **moyenne harmonique** pondérée par :math:`\partial B_\nu/\partial T`.
- Les fréquences où :math:`\chi_\nu` est *faible* (fenêtres de faible opacité) dominent :
  le rayonnement s'échappe par les canaux les plus transparents.
- Le flux intégré en fréquence devient :

  .. math::

     \mathbf{F} = -\frac{c}{3\,\kappa_R}\,\nabla\!\left(aT^4\right)
               = -\frac{4\,a\,c\,T^3}{3\,\kappa_R}\,\nabla T

  C'est la formule de **conduction radiative** utilisée dans les équations de structure
  stellaire.

Validité et Domaines de Rupture
--------------------------------

L'approximation de diffusion est valide lorsque :

1. **Grande profondeur optique** : :math:`\tau \gg 1` globalement, de sorte que le libre
   parcours moyen :math:`\ell = 1/\chi` est bien inférieur à l'échelle de gradient
   :math:`L \sim |\nabla E|^{-1} E`.

2. **Faible anisotropie** : le flux vérifie :math:`F \ll c\,E`, c'est-à-dire que le
   rayonnement n'est pas trop éloigné de l'isotropie.

3. **Variation temporelle lente** : les variations sont lentes devant le temps de libre
   parcours moyen :math:`\ell/c`.

Elle **se rompt** au voisinage de :

- **Surfaces et interfaces** où :math:`\tau \sim 1`.
- **Régions optiquement minces** (:math:`\tau < 1`) comme les vents ou les couronnes.
- **Zones d'ombre** ou à proximité de sources intenses où le champ est fortement anisotrope.
- **Gradients très raides** (chocs, fronts d'ionisation).

.. warning::

   Appliquée dans des régions optiquement minces, l'approximation de diffusion peut
   produire des flux supersoniques non physiques (:math:`F > c\,E`). Des **limiteurs de
   flux** sont nécessaires pour rétablir la causalité dans ces situations.

Limiteurs de Flux
~~~~~~~~~~~~~~~~~

Un remède courant consiste à remplacer le coefficient de diffusion par une version limitée :

.. math::

   D_{\rm lim} = \frac{c\,\lambda}{\chi}, \qquad
   \lambda = \frac{1}{3 + R}, \quad
   R = \frac{|\nabla E|}{\chi\, E}

- Quand :math:`R \to 0` (limite épaisse) : :math:`\lambda \to 1/3`, et l'on retrouve la
  diffusion standard.
- Quand :math:`R \to \infty` (limite mince) : :math:`\lambda \to 1/R`, ce qui donne
  :math:`F \to c\,E`, la limite de transport libre (free-streaming).

Applications
------------

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - Domaine
     - Rôle de l'approximation de diffusion
   * - **Intérieurs stellaires**
     - Transport d'énergie ; l'opacité de Rosseland entre dans les équations de structure
   * - **Fusion par confinement inertiel**
     - Rayonnement dans les hohlraums (:math:`\tau \sim 10^3`–:math:`10^5`)
   * - **Transfert radiatif atmosphérique**
     - Approximations à deux flux et d'Eddington pour les couches nuageuses
   * - **Transport neutronique**
     - Équation de diffusion des neutrons (mathématiquement identique)
   * - **Imagerie médicale (DOT)**
     - Tomographie optique diffuse dans les tissus biologiques

Récapitulatif
-------------

.. list-table::
   :header-rows: 0
   :widths: 42 58

   * - Régime de validité
     - :math:`\tau \gg 1`
   * - Fermeture
     - :math:`P_{ij} = \tfrac{1}{3}\,E\,\delta_{ij}`
   * - Loi de Fick
     - :math:`\mathbf{F} = -\tfrac{c}{3\chi}\,\nabla E`
   * - EDP gouvernante
     - :math:`\partial_t E - \nabla\!\cdot\!(D\nabla E) = \text{source}`
   * - Moyenne en fréquence
     - Moyenne de Rosseland :math:`\kappa_R`
   * - Domaines de rupture
     - Surfaces, régions minces, gradients raides
   * - Correction
     - Limiteurs de flux ou méthode du facteur d'Eddington variable (VEF)

.. seealso::

   :doc:`transfert_radiatif` pour l'ETR complète et les équations de moments dont
   cette approximation est dérivée.
