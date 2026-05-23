Méthode DOM 1D (Chandrasekhar) sans Fluorescence
=================================================

.. contents:: Table des matières
   :depth: 3
   :local:

Introduction
------------

La **méthode des ordonnées discrètes** (DOM, Discrete Ordinates Method), développée par
Chandrasekhar (1950) pour le transfert radiatif stellaire, résout l'ETR **complète**
sans recourir à l'approximation de diffusion. Elle constitue donc une **résolution
exacte** dans le cadre du modèle ETR choisi (fonction de phase, paramètres optiques),
limitée ici au cas **1D** (milieu plan-parallèle, invariance transverse).

L'intensité spécifique ne dépend que de $z$ et de l'angle polaire $\mu = \cos\theta$
par rapport à l'axe $z$.

Formulation 1D de l'ETR
------------------------

En géométrie 1D plan-parallèle, l'ETR stationnaire s'écrit :

$$\mu\,\frac{dI(\tau,\mu)}{d\tau} = -I(\tau,\mu) + S(\tau,\mu)$$

avec la profondeur optique $d\tau = \chi\,dz$ (positive vers le bas),
$\mu \in [-1,1]$ et la fonction source :

$$S(\tau,\mu) = (1-\varpi)\,B(T) + \frac{\varpi}{2}\int_{-1}^{1}p(\mu',\mu)\,I(\tau,\mu')\,d\mu'$$

où $\varpi = \sigma/\chi$ est l'albédo de diffusion simple.
Pour un milieu purement diffusant ($\varpi = 1$, pas d'absorption ni d'émission
thermique), la fonction source se réduit au terme de diffusion.

Discrétisation Angulaire — Quadrature de Gauss
-----------------------------------------------

On remplace l'intégrale angulaire par une **quadrature de Gauss-Legendre** à $N$
points dans $[-1,1]$ :

$$\int_{-1}^{1} f(\mu')\,d\mu' \approx \sum_{j=1}^{N} w_j\,f(\mu_j)$$

où les $\mu_j$ sont les racines du polynôme de Legendre $P_N$ et $w_j$ les poids
associés. On utilise typiquement $N$ pair (symétrie $\mu_{N+1-j} = -\mu_j$,
$w_{N+1-j} = w_j$) pour traiter séparément les directions montantes et descendantes.

L'ETR continue devient le **système de $N$ EDO couplées** :

$$\mu_i\,\frac{dI_i(\tau)}{d\tau} = -I_i(\tau) + \frac{\varpi}{2}\sum_{j=1}^{N} w_j\,p(\mu_j,\mu_i)\,I_j(\tau)
+ (1-\varpi)\,B(T), \quad i = 1,\ldots,N$$

avec $I_i(\tau) = I(\tau,\mu_i)$.

Formulation Matricielle
------------------------

En posant $\mathbf{I} = (I_1,\ldots,I_N)^\top$, le système s'écrit :

$$\mathbf{M}\,\frac{d\mathbf{I}}{d\tau} = -\mathbf{I} + \mathbf{P}\,\mathbf{I} + \mathbf{b}
= (\mathbf{P}-\mathbf{I}_N)\,\mathbf{I} + \mathbf{b}$$

$$\frac{d\mathbf{I}}{d\tau} = \mathbf{M}^{-1}(\mathbf{P}-\mathbf{I}_N)\,\mathbf{I} + \mathbf{M}^{-1}\mathbf{b}
= \mathbf{A}\,\mathbf{I} + \mathbf{b}'$$

où $\mathbf{M} = \text{diag}(\mu_1,\ldots,\mu_N)$ et la matrice de diffusion est
$P_{ij} = (\varpi/2)\,w_j\,p(\mu_j,\mu_i)$.

Résolution par Décomposition en Valeurs Propres
-------------------------------------------------

La solution homogène du système $d\mathbf{I}/d\tau = \mathbf{A}\,\mathbf{I}$ est :

$$\mathbf{I}_\text{hom}(\tau) = \sum_{k=1}^{N} c_k\,\mathbf{v}_k\,e^{\lambda_k\tau}$$

où $(\lambda_k, \mathbf{v}_k)$ sont les couples valeurs propres / vecteurs propres
de $\mathbf{A}$.

Propriétés spectrales :

- Les valeurs propres sont **réelles** et viennent par paires $(\lambda_k, -\lambda_k)$,
  avec $\text{Re}(\lambda_k) > 0$ pour $k \le N/2$.
- Pour un milieu conservatif ($\varpi = 1$), deux valeurs propres nulles $\lambda = 0$
  apparaissent (modes diffusifs à longue portée).

Conditions aux Limites
-----------------------

Pour un milieu semi-infini éclairé en $\tau = 0$ par une source $I^+(\mu_i)$
(directions montantes, $\mu_i > 0$) :

- **Condition en surface** ($\tau = 0$) : $I_i(0) = I^+(\mu_i)$ pour $\mu_i > 0$.
- **Condition à l'infini** : les termes croissants ($e^{+\lambda_k\tau}$ avec $\lambda_k > 0$) sont exclus.

Pour un **slab** d'épaisseur $\tau_L$ :

- Conditions en $\tau = 0$ : $I_i(0) = I^+(\mu_i)$ pour $\mu_i > 0$.
- Conditions en $\tau = \tau_L$ : $I_i(\tau_L) = I^-(\mu_i)$ pour $\mu_i < 0$.

Les constantes $c_k$ sont déterminées par un système linéaire $N \times N$.

Réflectance et Transmittance
------------------------------

La **réflectance diffuse** (flux remonté en $\tau = 0$) est :

$$R = \sum_{\mu_i < 0} w_i\,|\mu_i|\,I_i(0)$$

La **transmittance diffuse** (flux sorti en $\tau = \tau_L$) est :

$$T = \sum_{\mu_i > 0} w_i\,|\mu_i|\,I_i(\tau_L)$$

Convergence et Choix de $N$
-----------------------------

La précision croît avec $N$ (ordre de la quadrature). En pratique :

- $N = 2$ (approximation $S_2$) ≈ approximation de diffusion $P_1$.
- $N = 4$ à $N = 8$ : précision suffisante pour la plupart des applications.
- $N \ge 16$ : nécessaire pour les milieux à faible albédo ou anisotropie forte.

La DOM $S_N$ avec $N \to \infty$ converge vers la solution exacte de l'ETR.

Avantages et Limitations
--------------------------

- **Exact** (dans le cadre de l'ETR et du choix de $p$) : pas d'hypothèse sur $\mu_s'/\mu_a$.
- **Valide près des sources et interfaces** : contrairement à la DA.
- Résolution : $O(N^2)$ par couche, scalable.
- **Limité au 1D** plan-parallèle dans cette formulation ; l'extension 2D/3D nécessite
  des approches supplémentaires (DOM multidimensionnel, méthode Monte Carlo).

.. seealso::

   :doc:`01_etablissement_etr` — ETR complète que la DOM résout sans approximation.

   :doc:`11_dom_1d_avec_fluo` — extension de la DOM à la fluorescence.

   :doc:`03_approximation_diffusion` — approximation de diffusion, cas limite $N=2$.
