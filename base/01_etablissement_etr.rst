Établissement de l'Équation du Transfert Radiatif
==================================================

.. contents:: Table des matières
   :depth: 3
   :local:

Introduction
------------

L'équation du transfert radiatif (ETR) est l'équation de bilan qui gouverne l'évolution
de la **luminance** $I_\nu(\mathbf{r}, \hat{\mathbf{n}}, t)$ d'un rayonnement se
propageant dans un milieu pouvant l'absorber, l'émettre et le diffuser. Son établissement
repose sur un bilan de photons dans un volume élémentaire de l'espace des phases
(position × direction × fréquence).

La grandeur $I_\nu$ représente l'énergie rayonnante transportée par unité de temps,
d'aire perpendiculaire, d'angle solide et d'intervalle de fréquence, dans la direction
$\hat{\mathbf{n}}$ au point $\mathbf{r}$ à l'instant $t$ :

$$dE = I_\nu(\mathbf{r}, \hat{\mathbf{n}}, t)\;\cos\theta\;dA\;d\Omega\;d\nu\;dt$$

Grandeurs dérivées
------------------

L'intégration angulaire de $I_\nu$ donne les trois moments fondamentaux :

- **Fluence** $\Phi_\nu = \int_{4\pi} I_\nu\,d\Omega$ (W cm$^{-2}$ Hz$^{-1}$)
- **Densité d'énergie** $u_\nu = \Phi_\nu / c$ (J cm$^{-3}$ Hz$^{-1}$)
- **Vecteur flux** $\mathbf{F}_\nu = \int_{4\pi} I_\nu\,\hat{\mathbf{n}}\,d\Omega$ (W cm$^{-2}$ Hz$^{-1}$)
- **Tenseur de pression** $\mathbf{P}_\nu = \frac{1}{c}\int_{4\pi} I_\nu\,\hat{\mathbf{n}}\otimes\hat{\mathbf{n}}\,d\Omega$

Bilan dans un Volume Élémentaire
---------------------------------

On considère un cylindre élémentaire de section $dA$, de longueur $ds = c\,dt$,
orienté selon $\hat{\mathbf{n}}$. Quatre processus contribuent au bilan d'énergie.

**Transport.** La propagation libre le long de $\hat{\mathbf{n}}$ contribue :

$$\left.\frac{\partial I_\nu}{\partial t}\right|_\text{transp} = -c\,\hat{\mathbf{n}}\cdot\nabla I_\nu$$

**Absorption.** Le milieu absorbe une fraction proportionnelle au coefficient
d'absorption $\kappa_\nu$ (cm$^{-1}$) :

$$\left.\frac{\partial I_\nu}{\partial t}\right|_\text{abs} = -c\,\kappa_\nu\,I_\nu$$

**Émission thermique.** En équilibre thermodynamique local (ETL), la loi de Kirchhoff
donne une émissivité égale à l'absorptivité, d'où :

$$\left.\frac{\partial I_\nu}{\partial t}\right|_\text{ém} = c\,\kappa_\nu\,B_\nu(T)$$

où $B_\nu(T) = \frac{2h\nu^3}{c^2}\frac{1}{e^{h\nu/k_BT}-1}$ est la **fonction de Planck**.

**Diffusion élastique.** Le milieu dévie les photons sans changer leur fréquence.
Deux contributions s'opposent : la *perte* hors de la direction $\hat{\mathbf{n}}$
(coefficient de diffusion $\sigma_\nu$) et le *gain* par rediffusion depuis toutes
les directions $\hat{\mathbf{n}}'$, pondéré par la **fonction de phase**
$p(\hat{\mathbf{n}}',\hat{\mathbf{n}})$ :

$$\left.\frac{\partial I_\nu}{\partial t}\right|_\text{diff}
= c\,\sigma_\nu\left[
  -I_\nu(\hat{\mathbf{n}})
  + \int_{4\pi} p(\hat{\mathbf{n}}',\hat{\mathbf{n}})\,I_\nu(\hat{\mathbf{n}}')\,\frac{d\Omega'}{4\pi}
\right]$$

La fonction de phase est normalisée : $\int_{4\pi} p\,d\Omega'/(4\pi) = 1$.

L'Équation du Transfert Radiatif
---------------------------------

En regroupant les quatre contributions, on obtient l'ETR :

$$\boxed{
\frac{1}{c}\frac{\partial I_\nu}{\partial t}
+ \hat{\mathbf{n}} \cdot \nabla I_\nu
= -\chi_\nu\,I_\nu
  + \kappa_\nu\,B_\nu(T)
  + \sigma_\nu \int_{4\pi} p(\hat{\mathbf{n}}',\hat{\mathbf{n}})\,I_\nu(\hat{\mathbf{n}}')\,\frac{d\Omega'}{4\pi}
  + q_\nu
}$$

avec l'**opacité totale** $\chi_\nu = \kappa_\nu + \sigma_\nu$,
l'**albédo de diffusion simple** $\varpi_\nu = \sigma_\nu/\chi_\nu \in [0,1]$,
et $q_\nu$ un terme de source externe (laser, etc.).

Profondeur Optique et Solution Formelle
----------------------------------------

La **profondeur optique** le long du rayon est $d\tau_\nu = \chi_\nu\,ds$.
Un milieu est *optiquement mince* si $\tau_\nu \ll 1$ (photons libres)
et *optiquement épais* si $\tau_\nu \gg 1$ (nombreuses interactions).

La solution formelle intégrée le long du rayon est :

$$I_\nu(\tau_\nu) = I_\nu(0)\,e^{-\tau_\nu}
+ \int_0^{\tau_\nu} S_\nu(\tau_\nu')\,e^{-(\tau_\nu-\tau_\nu')}\,d\tau_\nu'$$

avec la **fonction source** $S_\nu = (\kappa_\nu B_\nu + \sigma_\nu J_\nu)/\chi_\nu$
et l'intensité moyenne $J_\nu = \frac{1}{4\pi}\int I_\nu\,d\Omega$.

Fonctions de Phase
-------------------

**Diffusion isotrope** : $p = 1$. Valide pour les très petites particules ($x = 2\pi a/\lambda \ll 1$).

**Henyey–Greenstein (1941)** : modèle analytique très utilisé en milieux biologiques et nuageux,

$$p_\text{HG}(\cos\theta) = \frac{1-g^2}{\left(1+g^2-2g\cos\theta\right)^{3/2}}$$

où $g = \langle\cos\theta\rangle \in [-1,1]$ est le **facteur d'anisotropie**.
Pour les tissus biologiques, $g \approx 0{,}9$ (diffusion fortement vers l'avant).

Coefficients Réduits
---------------------

En diffusion anisotrope, on définit le **coefficient de diffusion réduit**
$\mu_s' = \mu_s(1-g)$ et l'**opacité réduite** $\mu_t' = \mu_a + \mu_s'$.
Le **libre parcours moyen de transport** $\ell^* = 1/\mu_t'$ est l'échelle au-delà
de laquelle le rayonnement perd la mémoire de sa direction initiale — c'est la
condition de validité de l'approximation de diffusion (voir :doc:`03_approximation_diffusion`).

Équations de Moments
---------------------

L'intégration angulaire de l'ETR génère une hiérarchie. Les deux premiers moments sont :

$$\frac{\partial u_\nu}{\partial t} + \nabla\cdot\mathbf{F}_\nu
= c\,\kappa_\nu(4\pi B_\nu - c\,u_\nu)$$

$$\frac{1}{c^2}\frac{\partial \mathbf{F}_\nu}{\partial t} + \nabla\cdot\mathbf{P}_\nu
= -\chi_\nu\,\frac{\mathbf{F}_\nu}{c}$$

Ces équations sont exactes mais **non fermées** : $\mathbf{P}_\nu$ dépend de $I_\nu$.
La fermeture d'Eddington (approximation de diffusion) est présentée dans
:doc:`03_approximation_diffusion`.

.. seealso::

   :doc:`02_fluorescence_etr` — extension à la fluorescence (couple d'ETR).

   :doc:`03_approximation_diffusion` — réduction de l'ETR à une équation de diffusion.
