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

Transformée de Fourier 2D Transverse
--------------------------------------

On définit la transformée de Fourier 2D sur $(x,y)$ avec la fréquence spatiale
radiale $s_r = \sqrt{s_x^2+s_y^2}$ (rad cm$^{-1}$) :

$$\tilde f(s_r, z) = \int\!\!\int f(x,y,z)\,e^{-j(s_x x+s_y y)}\,dx\,dy$$

Comme $\nabla_\perp^2 f \xrightarrow{\mathcal{F}} -s_r^2\,\tilde f$, l'équation de
diffusion $-D(\nabla_\perp^2+\partial_{zz})\Phi + \mu_a\Phi = \delta^{(2)}(\mathbf{r}_\perp)\delta(z-z_0)$
devient une **EDO 1D en $z$** :

$$\frac{d^2\tilde\Phi}{dz^2} - \alpha^2(s_r)\,\tilde\Phi = -\frac{1}{D}\,\delta(z-z_0)$$

avec le **coefficient d'atténuation axial** :

$$\boxed{\alpha(s_r) = \sqrt{s_r^2 + \frac{1}{\delta^2}} = \sqrt{s_r^2 + \frac{\mu_a}{D}}}$$

Résolution de l'EDO 1D
-----------------------

La solution générale de l'équation homogène est $A\,e^{+\alpha z}+B\,e^{-\alpha z}$.
La condition de bornitude ($z\to+\infty$) impose $A = 0$ pour $z > z_0$.
La condition aux limites extrapolée $\tilde\Phi(-z_b) = 0$ fixe le rapport entre
les deux exponentielles pour $z < z_0$.

En construisant la solution de Green 1D par raccordement en $z = z_0$ (continuité de
$\tilde\Phi$, saut de $d\tilde\Phi/dz = -1/D$) :

$$\tilde\Phi(s_r, z\le z_0) = \frac{1}{2\alpha D}
\left[e^{-\alpha(z_0-z)} - e^{-\alpha(z_0+z+2z_b)}\right]$$

On retrouve exactement la **structure dipôle** en espace de Fourier : terme de source
réelle en $e^{-\alpha|z-z_0|}$ et terme d'image en $e^{-\alpha(z+z_0+2z_b)}$.

Réflectance dans l'Espace de Fourier
--------------------------------------

La réflectance transformée est $\tilde R(s_r) = -D\,\partial_z\tilde\Phi|_{z=0}$ :

$$\boxed{
\tilde R(s_r) = \frac{1}{2}\,\frac{e^{-\alpha z_0} + e^{-\alpha(z_0+2z_b)}}{1+2AD\alpha}
}$$

Cette expression analytique fermée est directement utilisable pour l'ajustement des
mesures SFDI (Spatial Frequency Domain Imaging).

Retour dans l'Espace Réel — Transformée de Hankel
--------------------------------------------------

Par symétrie cylindrique, la transformée de Fourier inverse 2D se réduit à la
**transformée de Hankel d'ordre 0** :

$$R(r) = \frac{1}{2\pi}\int_0^\infty \tilde R(s_r)\,J_0(s_r\,r)\,s_r\,ds_r$$

L'évaluation analytique de cette intégrale (via les résidus) redonne exactement la
formule des dipôles :

$$\frac{1}{2\pi}\int_0^\infty \frac{e^{-\alpha z_+}}{2\alpha D}\,J_0(s_r r)\,s_r\,ds_r
= \frac{1}{4\pi D}\,\frac{e^{-\rho_+/\delta}}{\rho_+}$$

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

En **SFDI**, on illumine le milieu avec un patron sinusoïdal $I_0[1+M\cos(s_r x+\varphi)]$.
La réflectance mesurée AC est $M_\text{AC}(s_r) = M\,|\tilde R(s_r)|$.
En faisant varier $s_r$, on obtient le spectre $\tilde R(s_r)$ qu'on ajuste sur la
formule analytique pour extraire simultanément $\mu_a$ et $\mu_s'$.

La sensibilité aux paramètres optiques dépend de la fréquence :
aux basses fréquences ($s_r \to 0$, lumière uniforme), $\tilde R$ est surtout sensible
à $\mu_a$ ; aux hautes fréquences ($s_r \gg 1/\delta$), à $\mu_s'$ (signal superficiel).
L'ajustement multi-fréquence lève la dégénérescence entre $\mu_a$ et $\mu_s'$.

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
