Méthode DOM 1D (Chandrasekhar) avec Fluorescence
=================================================

Introduction
------------

On étend ici la méthode DOM 1D (voir :doc:`10_dom_1d_sans_fluo`) au cas **fluorescent**.
Le fluorophore crée un couplage entre le champ d'excitation à $\lambda_x$ et le champ
d'émission à $\lambda_m > \lambda_x$. Ce couplage apparaît comme un **terme source
supplémentaire** dans l'ETR d'émission, proportionnel à la fluence d'excitation
locale. Comme pour la DA (voir :doc:`../da/05_da_1d_dipoles_avec_fluo`), le système est
résolu **séquentiellement** : d'abord l'ETR d'excitation, puis l'ETR d'émission.

Système de Deux ETR 1D Couplées
---------------------------------

En géométrie plan-parallèle (dépendance en $\tau$ seule), les deux ETR sont :

**ETR d'excitation :**

$$\mu\,\frac{dI_x(\tau_x,\mu)}{d\tau_x}
= -I_x + \frac{\varpi_x}{2}\int_{-1}^{1}p_x(\mu',\mu)\,I_x(\tau_x,\mu')\,d\mu'
+ (1-\varpi_x')\,B_x + S_x(\tau_x,\mu)$$

avec l'albédo effectif $\varpi_x' = \sigma_x/(\kappa_x+\mu_{af}+\sigma_x)$ tenant
compte de l'absorption du fluorophore, et $d\tau_x = (\kappa_x+\mu_{af}+\sigma_x)\,dz$.

**ETR d'émission :**

$$\mu\,\frac{dI_m(\tau_m,\mu)}{d\tau_m}
= -I_m + \frac{\varpi_m}{2}\int_{-1}^{1}p_m(\mu',\mu)\,I_m(\tau_m,\mu')\,d\mu'
+ Q_f(\tau_m,\mu)$$

avec le **terme source fluorescent** :

$$Q_f(\tau_m,\mu) = \frac{\eta\,\mu_{af}}{4\pi}\,\Phi_x(z(\tau_m))
= \frac{\eta\,\mu_{af}}{4\pi}\int_{-1}^{1}I_x(z(\tau_m),\mu')\,d\mu'$$

et $d\tau_m = (\kappa_m+\sigma_m)\,dz$.

Discrétisation Angulaire des Deux ETR
---------------------------------------

On applique la même quadrature de Gauss-Legendre à $N$ points à chaque ETR.

**Système discret d'excitation** (identique à :doc:`10_dom_1d_sans_fluo`) :

$$\frac{d\mathbf{I}_x}{d\tau_x} = \mathbf{A}_x\,\mathbf{I}_x + \mathbf{b}_x'$$

**Système discret d'émission** :

$$\frac{d\mathbf{I}_m}{d\tau_m} = \mathbf{A}_m\,\mathbf{I}_m + \mathbf{q}_f(\tau_m)$$

où le vecteur de terme source fluorescent est :

$$q_{f,i}(\tau_m) = \frac{\eta\,\mu_{af}}{4\pi}(\mathbf{M}_x^{-1})_{ii}\sum_{j=1}^{N}w_j\,I_{x,j}(z(\tau_m))
\quad\text{(isotropie de l'émission)}$$

Plus simplement, comme l'émission de fluorescence est isotrope ($f(\hat{\mathbf{n}}) = 1/4\pi$) :

$$q_{f,i} = \frac{\eta\,\mu_{af}}{4\pi}\,\Phi_x^{(N)}(z), \quad
\Phi_x^{(N)}(z) = \sum_{j=1}^N w_j\,I_{x,j}(z)$$

Résolution — Étape 1 : Champ d'Excitation
------------------------------------------

On résout le système d'excitation par décomposition en valeurs propres de $\mathbf{A}_x$
(voir :doc:`10_dom_1d_sans_fluo`). On obtient $\mathbf{I}_x(\tau_x)$ et on en déduit
la fluence discrétisée $\Phi_x^{(N)}(z)$.

Résolution — Étape 2 : Champ d'Émission
-----------------------------------------

Le système d'émission est une EDO **non-homogène** avec un terme source connu $\mathbf{q}_f(z)$ :

$$\frac{d\mathbf{I}_m}{d\tau_m} = \mathbf{A}_m\,\mathbf{I}_m + \mathbf{q}_f(\tau_m)$$

**Solution homogène :** $\mathbf{I}_m^\text{hom}(\tau_m) = \sum_k c_k\,\mathbf{v}_k^{(m)}\,e^{\lambda_k^{(m)}\tau_m}$,
obtenue par décomposition en valeurs propres de $\mathbf{A}_m$.

**Solution particulière :** comme $\mathbf{q}_f$ est une combinaison d'exponentielles
$e^{\lambda_k^{(x)}\tau}$ (héritées de la solution d'excitation), la solution particulière
est cherchée sous la même forme par **variation des constantes** :

$$\mathbf{I}_m^\text{part}(\tau_m) = \sum_k \mathbf{p}_k\,e^{\lambda_k^{(x)}\tau_m}$$

$$\left(\lambda_k^{(x)}\,\mathbf{I}_N - \mathbf{A}_m\right)\mathbf{p}_k = \mathbf{r}_k$$

Ce système linéaire $N \times N$ est résolu pour chaque $k$ (non singulier si
$\lambda_k^{(x)}$ n'est pas valeur propre de $\mathbf{A}_m$, ce qui est généralement
le cas car $\lambda_x \neq \lambda_m$ dès que $\delta_x \neq \delta_m$).

**Solution complète :**

$$\mathbf{I}_m(\tau_m) = \mathbf{I}_m^\text{hom}(\tau_m) + \mathbf{I}_m^\text{part}(\tau_m)$$

Les constantes $c_k$ sont fixées par les conditions aux limites :
- Pas de flux incident de fluorescence en $\tau_m = 0$ (directions montantes) ;
- Termes croissants exclus (milieu semi-infini) ou conditions en $\tau_m = \tau_L$ (slab).

Réflectance de Fluorescence
-----------------------------

La réflectance de fluorescence en $\tau_m = 0$ est :

$$R_m = \sum_{\mu_i < 0} w_i\,|\mu_i|\,I_{m,i}(0)$$

C'est la grandeur inversée en FDOT pour reconstruire $\mu_{af}(\mathbf{r})$.

Extension Temporelle
---------------------

En régime temporel, la convolution avec le temps de vie $\tau_f$ s'exprime en domaine
fréquentiel ($\omega$) par le facteur $(1+j\omega\tau_f)^{-1}$ appliqué au terme source :

$$Q_f(\tau_m,\mu,\omega) = \frac{\eta\,\mu_{af}}{4\pi(1+j\omega\tau_f)}\,\tilde\Phi_x^{(N)}(z,\omega)$$

De plus, le terme $j\omega/c$ s'ajoute à $\chi$ dans chaque ETR (termes temporels).
La transformée inverse donne la TPSF de fluorescence.

Comparaison DOM vs DA — Cas Fluorescent
-----------------------------------------

.. list-table::
   :header-rows: 1
   :widths: 30 35 35

   * - Critère
     - DOM 1D
     - DA 2D (Kienle/dipôles)
   * - Hypothèse sur $\mu_s'/\mu_a$
     - Aucune
     - $\mu_s' \gg \mu_a$ requis
   * - Validité près des sources
     - Oui
     - Non ($r \lesssim \ell^*$)
   * - Géométrie
     - Plan-parallèle (1D)
     - Semi-infini (2D)
   * - Coût de calcul
     - $O(N^2)$ par profondeur
     - Analytique fermé
   * - Terme source fluorescent
     - $\Phi_x^{(N)}(z)$ discrète
     - $\Phi_x(r,z)$ analytique
   * - Extension multicouches
     - Raccordement par couche
     - Série d'images ou Fourier

.. seealso::

   :doc:`10_dom_1d_sans_fluo` — DOM sans fluorescence dont ce fichier est l'extension.

   :doc:`../da/07_da_2d_dipoles_avec_fluo` — résolution approchée 2D avec fluorescence.

   :doc:`../base/02_fluorescence_etr` — système d'ETR couplées à la base de ce traitement.
