DA 2D — Méthode de Kienle sans Fluorescence (Fréquences Spatiales)
===================================================================

Introduction
------------

La méthode de Kienle (Kienle & Patterson, 1997) résout l'équation de diffusion dans
un milieu semi-infini en décomposant le problème en **ondes planes** par une
transformée de Fourier 2D sur les coordonnées transverses $(x,y)$. Cette approche
réduit l'EDP 3D à une famille d'EDO 1D en $z$, résolues analytiquement. Elle est
**rigoureusement équivalente** à la méthode des dipôles (voir :doc:`06_da_2d_dipoles_sans_fluo`)
pour un milieu semi-infini homogène, mais se généralise naturellement aux milieux
multicouches et à la mesure dans l'espace de Fourier (SFDI).

Terme Source et Transformée de Fourier 2D Transverse
------------------------------------------------------

La source est un faisceau pencil beam $F_0\,e^{-\mu_t z}\,\delta^{(2)}(\boldsymbol{\rho})$.
On définit la transformée de Fourier 2D sur $(x,y)$ avec la fréquence spatiale
radiale $s_r = \sqrt{s_x^2+s_y^2}$ (rad mm$^{-1}$) :

$$\tilde f(s_r, z) = \int\!\!\int f(x,y,z)\,e^{-j(s_x x+s_y y)}\,dx\,dy$$

La transformée du terme source est :

$$\widetilde{F_0\,\mu_s'\,e^{-\mu_t z}\,\delta^{(2)}} = F_0\,\mu_s'\,e^{-\mu_t z}$$

Comme $\nabla_\perp^2 f \xrightarrow{\mathcal{F}} -s_r^2\,\tilde f$, l'équation de
diffusion devient une **EDO 1D en $z$** :

$$\frac{d^2\tilde\Phi}{dz^2} - \alpha^2(s_r)\,\tilde\Phi = -\frac{F_0\,\mu_s'}{D}\,e^{-\mu_t z}$$

avec le **coefficient d'atténuation axial** :

$$\boxed{\alpha(s_r) = \sqrt{s_r^2 + \frac{\mu_a}{D}} = \sqrt{s_r^2 + \frac{1}{\delta^2}}}$$

Résolution de l'EDO 1D
-----------------------

**Solution particulière.** On cherche $\tilde\Phi^\text{part} = P\,e^{-\mu_t z}$ :

$$P(\mu_t^2 - \alpha^2)\,e^{-\mu_t z} = -\frac{F_0\,\mu_s'}{D}\,e^{-\mu_t z}
\implies P = \frac{F_0\,\mu_s'}{D(\alpha^2-\mu_t^2)}$$

**Solution homogène.** La condition de bornitude ($z\to+\infty$) impose $e^{-\alpha z}$.
La condition aux limites extrapolée $\tilde\Phi(-z_b) = 0$ fixe la constante $B$ :

$$\tilde\Phi^\text{hom}(z) = B\,e^{-\alpha z}$$

$$B = -\tilde\Phi^\text{part}(-z_b)\,e^{-\alpha z_b}
= -\frac{F_0\,\mu_s'}{D(\alpha^2-\mu_t^2)}\,e^{\mu_t z_b}\,e^{-\alpha z_b}$$

**Solution complète :**

$$\tilde\Phi(s_r,z) = \frac{F_0\,\mu_s'}{D(\alpha^2-\mu_t^2)}
\left[e^{-\mu_t z} - e^{\mu_t z_b-\alpha(z+z_b)}\right]$$

On retrouve la **structure dipôle** en espace de Fourier par l'approximation
$\mu_t e^{-\mu_t z'} \approx \delta(z' - z_0)$ avec $z_0 = 1/\mu_t$ :

$$\tilde\Phi(s_r,z) \approx \frac{F_0\,\mu_s'}{2\alpha D\,\mu_t}
\left[e^{-\alpha|z-z_0|} - e^{-\alpha(z+z_0+2z_b)}\right]$$

Réflectance dans l'Espace de Fourier
--------------------------------------

La réflectance transformée $\tilde R(s_r) = -D\,\partial_z\tilde\Phi|_{z=0}$ :

$$\boxed{
\tilde R(s_r) = \frac{F_0\,\mu_s'}{2\mu_t}\,
\frac{e^{-\alpha z_0} + e^{-\alpha(z_0+2z_b)}}{1+2AD\alpha}
}$$

.. solution::

   En dérivant la solution complète exacte et en évaluant en $z=0$ :

   $$\tilde R = -D\,\frac{d\tilde\Phi}{dz}\bigg|_{z=0}
   = \frac{F_0\,\mu_s'}{D(\alpha^2-\mu_t^2)}\,
   \left[-(-\mu_t) + \alpha\,e^{\mu_t z_b - \alpha z_b}\right]\,(-D)$$

   Ce qui, après l'approximation dipôlaire, donne la forme factorisée ci-dessus.
   Le dénominateur $1+2AD\alpha$ provient de la condition aux limites extrapolée
   $z_b = 2AD$.

Cette expression analytique explicite est directement utilisable pour l'ajustement
des mesures SFDI (Spatial Frequency Domain Imaging).

Retour dans l'Espace Réel — Transformée de Hankel
--------------------------------------------------

Par symétrie cylindrique, la transformée de Fourier inverse 2D se réduit à la
**transformée de Hankel d'ordre 0** :

$$R(\rho) = \frac{1}{2\pi}\int_0^\infty \tilde R(s_r)\,J_0(s_r\,\rho)\,s_r\,ds_r$$

L'évaluation analytique de cette intégrale (via les résidus) redonne exactement la
formule des dipôles :

$$\frac{1}{2\pi}\int_0^\infty \frac{F_0\,\mu_s'}{2\mu_t}\,
\frac{e^{-\alpha z_+}}{2\alpha D}\,J_0(s_r \rho)\,s_r\,ds_r
= \frac{F_0\,\mu_s'}{4\pi D\,\mu_t}\,\frac{e^{-\rho_+/\delta}}{\rho_+}$$

L'équivalence entre les deux méthodes est donc exacte terme à terme.

Régime Fréquentiel et Temporel
--------------------------------

En régime fréquentiel ($\omega$), on substitue $\mu_a \leftarrow \mu_a+j\omega/c$,
ce qui rend $\alpha$ complexe :

$$\alpha(\omega,s_r) = \sqrt{s_r^2 + \frac{\mu_a+j\omega/c}{D}}$$

$\tilde R(s_r,\omega)$ est alors complexe (amplitude + phase mesurables).
La réponse temporelle (TPSF) s'obtient par transformée de Laplace inverse
de $\tilde R(s_r,s)$ avec $s = j\omega$.

Application à la SFDI
-----------------------

En **SFDI**, on illumine le milieu avec un patron sinusoïdal
$I_0[1+M\cos(s_r x+\varphi)]$.
La réflectance mesurée AC est $M_\text{AC}(s_r) = M\,|\tilde R(s_r)|$.
En faisant varier $s_r$, on obtient le spectre $\tilde R(s_r)$ qu'on ajuste sur la
formule analytique pour extraire simultanément $\mu_a$ et $\mu_s'$.

La sensibilité aux paramètres optiques dépend de la fréquence :
aux basses fréquences ($s_r \to 0$), $\tilde R$ est surtout sensible à $\mu_a$ ;
aux hautes fréquences ($s_r \gg 1/\delta$), à $\mu_s'$ (signal superficiel).

Extension aux Milieux Multicouches
-----------------------------------

Pour $N$ couches d'épaisseurs $L_i$ et paramètres $(\mu_{a,i}, \mu_{s,i}')$, chaque
couche $i$ a sa propre EDO avec $\alpha_i = \sqrt{s_r^2+\mu_{a,i}/D_i}$. La solution
dans chaque couche est $A_i e^{+\alpha_i z}+B_i e^{-\alpha_i z}$. Les coefficients
sont fixés par les conditions de raccordement (continuité de $\tilde\Phi$ et
$D_i\partial_z\tilde\Phi$) aux interfaces — système linéaire résolu pour chaque $s_r$.

.. seealso::

   :doc:`06_da_2d_dipoles_sans_fluo` — résolution équivalente dans l'espace réel.

   :doc:`09_da_2d_kienle_avec_fluo` — extension de cette méthode à la fluorescence.
