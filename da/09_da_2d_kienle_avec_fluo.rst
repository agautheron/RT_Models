DA 2D — Méthode de Kienle avec Fluorescence (Fréquences Spatiales)
===================================================================

Introduction
------------

On étend ici la méthode de Kienle (voir :doc:`08_da_2d_kienle_sans_fluo`) au cas
**fluorescent**. La source d'excitation est un faisceau pencil beam
$F_0\,e^{-\mu_{tx} z}\,\delta^{(2)}(\boldsymbol{\rho})$. La transformée de Fourier 2D
transverse est appliquée au système couplé (voir :doc:`../base/02_fluorescence_etr`),
ce qui donne deux EDO 1D en $z$ couplées par un terme source. Le découplage est
immédiat dans l'espace de Fourier.

Système d'EDO Couplées dans l'Espace de Fourier
-------------------------------------------------

Après transformation de Fourier 2D transverse, les deux équations de diffusion
(excitation et émission) deviennent :

**Excitation :**

$$\frac{d^2\tilde\Phi_x}{dz^2} - \alpha_x^2\,\tilde\Phi_x = -\frac{F_0\,\mu_{sx}'}{D_x}\,e^{-\mu_{tx} z}$$

$$\alpha_x = \sqrt{s_r^2 + \frac{\mu_{ax}^\text{tot}}{D_x}}, \quad
z_{0x} = \frac{1}{\mu_{tx}}, \quad
\delta_x = \sqrt{\frac{D_x}{\mu_{ax}^\text{tot}}}$$

**Émission :**

$$\frac{d^2\tilde\Phi_m}{dz^2} - \alpha_m^2\,\tilde\Phi_m = -\frac{\eta\,\mu_{af}}{D_m}\,\tilde\Phi_x(s_r,z)$$

$$\alpha_m = \sqrt{s_r^2 + \frac{\mu_{am}}{D_m}}, \quad \delta_m = \sqrt{\frac{D_m}{\mu_{am}}}$$

Le couplage est unidirectionnel : $\tilde\Phi_x$ pilote $\tilde\Phi_m$.

Résolution — Champ d'Excitation
---------------------------------

La solution complète de l'EDO d'excitation avec terme source exponentiel est
(voir :doc:`08_da_2d_kienle_sans_fluo`) :

$$\tilde\Phi_x(s_r,z) = \frac{F_0\,\mu_{sx}'}{D_x(\alpha_x^2-\mu_{tx}^2)}
\left[e^{-\mu_{tx} z} - e^{\mu_{tx} z_{bx}-\alpha_x(z+z_{bx})}\right]$$

Dans l'approximation dipôlaire ($\mu_{tx} e^{-\mu_{tx}z'} \approx \delta(z'-z_{0x})$) :

$$\tilde\Phi_x(s_r,z) \approx \frac{F_0\,\mu_{sx}'}{2\alpha_x D_x\,\mu_{tx}}
\left[e^{-\alpha_x|z-z_{0x}|} - e^{-\alpha_x(z+z_{0x}+2z_{bx})}\right]$$

Résolution — Champ d'Émission
--------------------------------

Le terme source de l'EDO d'émission est
$f_m(z) = -\frac{\eta\,\mu_{af}}{D_m}\,\tilde\Phi_x(s_r,z)$,
soit une combinaison de deux exponentielles $e^{-\alpha_x|z-z_s|}$ et $e^{-\mu_{tx}z}$.

**Solution particulière pour le terme balistique exact** $C_0\,e^{-\mu_{tx} z}$
($\alpha_x \neq \alpha_m$ et $\mu_{tx} \neq \alpha_m$) :

$$\tilde\Phi_{m,0}^\text{part}(z) = \frac{-\eta\,\mu_{af}\,F_0\,\mu_{sx}'/(D_m D_x)}{(\alpha_m^2-\mu_{tx}^2)(\alpha_x^2-\mu_{tx}^2)}\,e^{-\mu_{tx} z}$$

**Solution particulière pour chaque terme diffus** $C_s\,e^{-\alpha_x|z-z_s|}$
($\alpha_x \neq \alpha_m$) :

$$\tilde\Phi_{m,s}^\text{part}(z) = \frac{-C_s/D_m}{\alpha_m^2-\alpha_x^2}\,e^{-\alpha_x|z-z_s|}$$

.. solution::

   On injecte $\tilde\Phi^\text{part} = P\,e^{-\alpha_x z}$ (pour $z > z_s$) :

   $$P\,\alpha_x^2\,e^{-\alpha_x z} - \alpha_m^2 P\,e^{-\alpha_x z} = \frac{-C_s}{D_m}\,e^{-\alpha_x z}$$

   $$P = \frac{-C_s/D_m}{\alpha_m^2-\alpha_x^2}$$

   Ce résultat est formellement identique au cas 1D (voir :doc:`05_da_1d_dipoles_avec_fluo`)
   avec la substitution $1/\delta^2 \to \alpha^2 = s_r^2 + 1/\delta^2$.

La solution générale ajoute la solution homogène
$\tilde\Phi_m^\text{hom}(z) = B_m\,e^{-\alpha_m z}$ (terme borné), dont la constante
$B_m$ est fixée par la condition aux limites $\tilde\Phi_m(-z_{bm}) = 0$ :

$$\boxed{
\tilde\Phi_m(s_r,z) = \tilde\Phi_m^\text{part}(z) + B_m\,e^{-\alpha_m z}
}$$

$$B_m = -\tilde\Phi_m^\text{part}(-z_{bm})\,e^{-\alpha_m z_{bm}}$$

Réflectances dans l'Espace de Fourier
----------------------------------------

**Réflectance d'excitation** :

$$\tilde R_x(s_r) = -D_x\,\frac{d\tilde\Phi_x}{dz}\bigg|_{z=0}
\approx \frac{F_0\,\mu_{sx}'}{2\mu_{tx}}\,\frac{e^{-\alpha_x z_{0x}}+e^{-\alpha_x(z_{0x}+2z_{bx})}}{1+2A_xD_x\alpha_x}$$

**Réflectance d'émission :**

$$\tilde R_m(s_r) = -D_m\,\frac{d\tilde\Phi_m}{dz}\bigg|_{z=0}
= -D_m\left[\frac{d\tilde\Phi_m^\text{part}}{dz}\bigg|_{z=0} + B_m\,(-\alpha_m)\right]$$

En développant avec la solution particulière issue de $\tilde\Phi_x$ :

$$\tilde R_m(s_r) = \frac{\eta\,\mu_{af}\,F_0\,\mu_{sx}'}{2\mu_{tx}\,D_m(\alpha_m^2-\alpha_x^2)}
\left[\alpha_x\left(e^{-\alpha_x z_{0x}}+e^{-\alpha_x(z_{0x}+2z_{bx})}\right)
- \alpha_m\,B_m\right]$$

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

$$\frac{\eta\,\mu_{af}}{1+j\omega\tau_f}\,\tilde\Phi_x(s_r,z,\omega)$$

$\tilde R_m(s_r,\omega)$ est alors complexe. Sa phase encode le temps de vie $\tau_f$,
indépendamment de la géométrie.

Avantages par Rapport aux Dipôles 2D
---------------------------------------

- **Multicouches** : le passage en fréquences spatiales se généralise naturellement
  à $N$ couches par raccordement des solutions à chaque interface.
- **SFDI** : $\tilde R_m(s_r)$ est directement l'observable expérimental en SFDI
  fluorescente, sans transformée inverse intermédiaire.
- **Terme source exact** : l'EDO en $z$ préserve le terme $e^{-\mu_{tx}z}$ exact
  (sans approximation dipôlaire), contrairement à la méthode des dipôles 2D.

.. seealso::

   :doc:`07_da_2d_dipoles_avec_fluo` — résolution équivalente dans l'espace réel.

   :doc:`08_da_2d_kienle_sans_fluo` — même méthode sans fluorescence.

   :doc:`../base/02_fluorescence_etr` — système d'ETR couplées dont est issu ce système de DA.
