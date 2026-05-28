DA 2D — Méthode de Kienle avec Fluorescence (Fréquences Spatiales)
===================================================================

Introduction
------------

On étend ici la méthode de Kienle (voir :doc:`08_da_2d_kienle_sans_fluo`) au cas
**fluorescent**. La source d'excitation est un faisceau pencil beam
$F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$. Le terme source d'émission
inclut les deux contributions : photons diffus $\Phi_x$ et photons balistiques
$F_0 e^{-\mu_{tx}z}$. La transformée de Fourier 2D transverse donne deux EDO 1D
couplées résolues séquentiellement.

Système d'EDO Couplées dans l'Espace de Fourier
-------------------------------------------------

Après transformation de Fourier 2D transverse :

**Excitation :**

$$\frac{d^2\tilde\Phi_x}{dz^2} - \alpha_x^2\,\tilde\Phi_x = -\frac{F_0\,\mu_{sx}'}{D_x}\,e^{-\mu_{tx} z}$$

$$\alpha_x = \sqrt{s_r^2 + \frac{\mu_{ax}^\text{tot}}{D_x}}, \quad
z_{0x} = \frac{1}{\mu_{tx}}, \quad
\delta_x = \sqrt{\frac{D_x}{\mu_{ax}^\text{tot}}}$$

**Émission :**

La transformée de Fourier du terme source d'émission
$\eta\,\mu_{af}\!\left[\Phi_x(\mathbf{r}) + F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})\right]$
donne, en espace de Fourier ($\tilde\delta^{(2)} = 1$) :

$$\frac{d^2\tilde\Phi_m}{dz^2} - \alpha_m^2\,\tilde\Phi_m
= -\frac{\eta\,\mu_{af}}{D_m}\!\left[\tilde\Phi_x(s_r,z) + F_0\,e^{-\mu_{tx} z}\right]$$

$$\alpha_m = \sqrt{s_r^2 + \frac{\mu_{am}}{D_m}}, \quad \delta_m = \sqrt{\frac{D_m}{\mu_{am}}}$$

Le membre de droite est donc la somme de **trois termes exponentiels** en $z$ :
deux issus de $\tilde\Phi_x$ (terme balistique amorti + terme diffus image) et
un terme balistique direct $F_0\,e^{-\mu_{tx}z}$.

Résolution — Champ d'Excitation
---------------------------------

La solution complète de l'EDO d'excitation est
(voir :doc:`08_da_2d_kienle_sans_fluo`) :

$$\tilde\Phi_x(s_r,z) = \frac{F_0\,\mu_{sx}'}{D_x(\alpha_x^2-\mu_{tx}^2)}
\left[e^{-\mu_{tx} z} - e^{\mu_{tx} z_{bx}-\alpha_x(z+z_{bx})}\right]$$

Résolution — Champ d'Émission
--------------------------------

Le membre de droite de l'EDO d'émission est :

$$f_m(z) = -\frac{\eta\,\mu_{af}}{D_m}\!\left[\tilde\Phi_x(s_r,z) + F_0\,e^{-\mu_{tx}z}\right]$$

En substituant $\tilde\Phi_x$ :

$$f_m(z) = -\frac{\eta\,\mu_{af}\,F_0}{D_m}\left[
\underbrace{\left(\frac{\mu_{sx}'}{D_x(\alpha_x^2-\mu_{tx}^2)} + 1\right)}_{\displaystyle\equiv\,K_0}\,e^{-\mu_{tx} z}
- \frac{\mu_{sx}'}{D_x(\alpha_x^2-\mu_{tx}^2)}\,e^{\mu_{tx} z_{bx}-\alpha_x(z+z_{bx})}
\right]$$

On a donc deux types de termes sources à traiter :

**Type A** : $C_A\,e^{-\mu_{tx} z}$ — solution particulière ($\alpha_m \neq \mu_{tx}$) :

$$\tilde\Phi_{m,A}^\text{part}(z) = \frac{C_A}{\alpha_m^2-\mu_{tx}^2}\,e^{-\mu_{tx} z}$$

avec $C_A = \frac{\eta\,\mu_{af}\,F_0}{D_m}\,K_0
= \frac{\eta\,\mu_{af}\,F_0}{D_m}\!\left(\frac{\mu_{sx}'}{D_x(\alpha_x^2-\mu_{tx}^2)}+1\right)$.

**Type B** : $C_B\,e^{-\alpha_x(z+z_{bx})}$ — solution particulière ($\alpha_m \neq \alpha_x$) :

$$\tilde\Phi_{m,B}^\text{part}(z) = \frac{C_B}{\alpha_m^2-\alpha_x^2}\,e^{-\alpha_x(z+z_{bx})}$$

avec $C_B = -\frac{\eta\,\mu_{af}\,F_0\,\mu_{sx}'}{D_m D_x(\alpha_x^2-\mu_{tx}^2)}\,e^{\mu_{tx} z_{bx}}$.

.. solution::

   Pour le type A, on injecte $P\,e^{-\mu_{tx}z}$ :

   $$P\mu_{tx}^2\,e^{-\mu_{tx}z} - \alpha_m^2 P\,e^{-\mu_{tx}z} = C_A\,e^{-\mu_{tx}z}
   \implies P = \frac{-C_A}{\alpha_m^2-\mu_{tx}^2}$$

   soit $\tilde\Phi_{m,A}^\text{part} = C_A/(\alpha_m^2-\mu_{tx}^2)\,e^{-\mu_{tx}z}$
   (avec $C_A$ déjà affecté d'un signe $-$ dans la définition de $f_m$).

   Pour le type B, identique avec $\alpha_x$ à la place de $\mu_{tx}$.

   Le facteur $K_0 = \mu_{sx}'/(D_x(\alpha_x^2-\mu_{tx}^2))+1$ regroupe la contribution
   de $\tilde\Phi_x$ **et** celle du terme balistique direct. À $s_r = 0$ et dans
   l'espace réel ($\alpha_x = 1/\delta_x$), on retrouve le préfacteur du cas 1D.

La solution générale ajoute la solution homogène bornée
$B_m\,e^{-\alpha_m z}$, dont la constante est fixée par
$\tilde\Phi_m(-z_{bm}) = 0$ :

$$\boxed{
\tilde\Phi_m(s_r,z) = \tilde\Phi_{m,A}^\text{part}(z) + \tilde\Phi_{m,B}^\text{part}(z) + B_m\,e^{-\alpha_m z}
}$$

$$B_m = -\left[\tilde\Phi_{m,A}^\text{part}(-z_{bm}) + \tilde\Phi_{m,B}^\text{part}(-z_{bm})\right]e^{-\alpha_m z_{bm}}$$

Réflectances dans l'Espace de Fourier
----------------------------------------

**Réflectance d'excitation** :

$$\tilde R_x(s_r) = -D_x\,\frac{d\tilde\Phi_x}{dz}\bigg|_{z=0}
= \frac{F_0\,\mu_{sx}'}{D_x(\alpha_x^2-\mu_{tx}^2)}\!\left[-\mu_{tx} + \alpha_x\,e^{\mu_{tx}z_{bx}-\alpha_x z_{bx}}\right](-D_x)$$

**Réflectance d'émission** :

$$\tilde R_m(s_r) = -D_m\,\frac{d\tilde\Phi_m}{dz}\bigg|_{z=0}$$

En développant :

$$\tilde R_m(s_r) = -D_m\left[
-\frac{\mu_{tx}\,C_A}{\alpha_m^2-\mu_{tx}^2}
- \frac{\alpha_x\,C_B\,e^{-\alpha_x z_{bx}}}{\alpha_m^2-\alpha_x^2}
+ B_m(-\alpha_m)
\right]$$

Ces deux quantités sont les données directement mesurables en SFDI fluorescente.

Retour dans l'Espace Réel
--------------------------

Par transformée de Hankel inverse :

$$R_m(\rho) = \frac{1}{2\pi}\int_0^\infty \tilde R_m(s_r)\,J_0(s_r\,\rho)\,s_r\,ds_r$$

Cette intégrale est calculée numériquement (algorithme de Hankel rapide). Elle redonne
la même réflectance que la méthode des dipôles 2D (voir :doc:`07_da_2d_dipoles_avec_fluo`).

Régime Fréquentiel et Temporel
--------------------------------

En régime fréquentiel ($\omega$), on substitue $\mu_{a\lambda} \leftarrow \mu_{a\lambda}+j\omega/c$
dans les deux équations, et le terme de couplage fluorescent devient :

$$\frac{\eta\,\mu_{af}}{1+j\omega\tau_f}\!\left[\tilde\Phi_x(s_r,z,\omega) + F_0\,e^{-\mu_{tx}z}\right]$$

$\tilde R_m(s_r,\omega)$ est alors complexe. Sa phase encode le temps de vie $\tau_f$,
indépendamment de la géométrie.

Avantages par Rapport aux Dipôles 2D
---------------------------------------

- **Terme source exact** : l'EDO en $z$ préserve le terme $e^{-\mu_{tx}z}$ exact
  et la contribution balistique directe au terme source d'émission, sans approximation
  dipôlaire supplémentaire.
- **Multicouches** : le passage en fréquences spatiales se généralise naturellement
  à $N$ couches par raccordement des solutions à chaque interface.
- **SFDI** : $\tilde R_m(s_r)$ est directement l'observable expérimental en SFDI
  fluorescente, sans transformée inverse intermédiaire.

.. seealso::

   :doc:`07_da_2d_dipoles_avec_fluo` — résolution équivalente dans l'espace réel.

   :doc:`08_da_2d_kienle_sans_fluo` — même méthode sans fluorescence.

   :doc:`../base/02_fluorescence_etr` — système d'ETR couplées dont est issu ce système de DA.
