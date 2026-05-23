Transfert Radiatif
==================

.. contents:: Table des matières
   :depth: 3
   :local:

Introduction
------------

Le transfert radiatif décrit la propagation du rayonnement électromagnétique à travers
un milieu susceptible de l'**absorber**, de l'**émettre** et de le **diffuser**. Il est
fondamental en astrophysique, en physique des atmosphères, en génie nucléaire et en
imagerie médicale.

La grandeur centrale est l'**intensité spécifique** (ou luminance) :math:`I_\nu(\mathbf{r}, \hat{\mathbf{n}}, t)`,
qui représente l'énergie transportée par unité de temps, de surface, d'angle solide et
d'intervalle de fréquence, dans la direction :math:`\hat{\mathbf{n}}` au point
:math:`\mathbf{r}` et à l'instant :math:`t`.

L'Équation du Transfert Radiatif
---------------------------------

Forme générale
~~~~~~~~~~~~~~

L'équation du transfert radiatif (ETR) gouverne l'évolution de :math:`I_\nu` le long
d'un rayon :

.. math::

   \frac{1}{c}\frac{\partial I_\nu}{\partial t}
   + \hat{\mathbf{n}} \cdot \nabla I_\nu
   = -(\kappa_\nu + \sigma_\nu)\, I_\nu
     + \kappa_\nu\, B_\nu(T)
     + \frac{\sigma_\nu}{4\pi} \int_{4\pi} I_\nu(\hat{\mathbf{n}}')\, d\Omega'

où :

- :math:`\kappa_\nu` — opacité d'absorption (cm\ :sup:`−1`)
- :math:`\sigma_\nu` — opacité de diffusion (cm\ :sup:`−1`)
- :math:`B_\nu(T)` — fonction de Planck (source d'émission thermique)
- le terme intégral — rediffusion isotrope entrante (hypothèse de diffusion cohérente et isotrope)

L'opacité totale est :math:`\chi_\nu = \kappa_\nu + \sigma_\nu`, et l'**albédo de
diffusion simple** est :

.. math::

   \varpi_\nu = \frac{\sigma_\nu}{\chi_\nu} \in [0,\, 1]

Profondeur optique
~~~~~~~~~~~~~~~~~~

Le long d'un rayon paramétré par l'abscisse curviligne :math:`s`, la **profondeur
optique** est définie par :

.. math::

   d\tau_\nu = \chi_\nu\, ds

Un milieu est dit :

- **optiquement mince** si :math:`\tau_\nu \ll 1` — les photons s'échappent librement.
- **optiquement épais** si :math:`\tau_\nu \gg 1` — les photons subissent de nombreuses
  interactions avant de pouvoir se propager sur une grande distance.

Solution formelle
~~~~~~~~~~~~~~~~~

En régime stationnaire et le long d'un rayon unique, la solution formelle de l'ETR est :

.. math::

   I_\nu(\tau_\nu) = I_\nu(0)\, e^{-\tau_\nu}
   + \int_0^{\tau_\nu} S_\nu(\tau_\nu')\, e^{-(\tau_\nu - \tau_\nu')}\, d\tau_\nu'

où la **fonction source** est :

.. math::

   S_\nu = \frac{\kappa_\nu B_\nu + \sigma_\nu J_\nu}{\chi_\nu}

et :math:`J_\nu = \frac{1}{4\pi}\int I_\nu\, d\Omega` est l'intensité moyenne.

Le premier terme représente l'intensité incidente atténuée ; le second est la
contribution intégrée de l'émission et de la diffusion le long du trajet.

Moments du Champ de Rayonnement
--------------------------------

L'intégration de :math:`I_\nu` sur l'angle solide donne les **moments du rayonnement** :

.. list-table::
   :header-rows: 1
   :widths: 28 38 34

   * - Moment
     - Définition
     - Signification physique
   * - Intensité moyenne :math:`J_\nu`
     - :math:`\frac{1}{4\pi}\int I_\nu\, d\Omega`
     - Densité d'énergie (à :math:`4\pi/c` près)
   * - Flux :math:`\mathbf{F}_\nu`
     - :math:`\int I_\nu\, \hat{\mathbf{n}}\, d\Omega`
     - Flux net d'énergie par unité de surface
   * - Tenseur de pression :math:`\mathbf{P}_\nu`
     - :math:`\frac{1}{c}\int I_\nu\, \hat{\mathbf{n}}\otimes\hat{\mathbf{n}}\, d\Omega`
     - Flux de quantité de mouvement du rayonnement

Les équations de moments d'ordre 0 et 1 de l'ETR donnent :

.. math::

   \frac{\partial E_\nu}{\partial t} + \nabla \cdot \mathbf{F}_\nu
   = c\,\kappa_\nu\,(4\pi B_\nu - c\,E_\nu)

.. math::

   \frac{1}{c^2}\frac{\partial \mathbf{F}_\nu}{\partial t} + \nabla \cdot \mathbf{P}_\nu
   = -\chi_\nu\, \frac{\mathbf{F}_\nu}{c}

avec :math:`E_\nu = 4\pi J_\nu / c` la densité d'énergie radiative. Ces équations sont
exactes mais **non fermées** : :math:`\mathbf{P}_\nu` dépend de :math:`I_\nu`. Une
relation de fermeture est nécessaire — l'**approximation de diffusion** en fournit une
dans la limite optiquement épaisse.

.. seealso::

   :doc:`approximation_diffusion` pour la dérivation et les conditions de validité
   de cette fermeture.
