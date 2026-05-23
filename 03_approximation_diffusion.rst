Approximation de la Diffusion
==============================

Introduction
------------

Dans un milieu **optiquement épais et fortement diffusant** ($\mu_s' \gg \mu_a$,
$\tau \gg 1$), les photons subissent un très grand nombre de diffusions avant de
s'échapper. Le champ devient presque **isotrope** et la dépendance angulaire de
$I(\mathbf{r},\hat{\mathbf{n}},t)$ peut être réduite à ses deux premiers moments.
L'ETR se simplifie alors en une **équation de diffusion** scalaire pour la fluence
$\Phi(\mathbf{r},t)$.

Développement $P_1$ — Fermeture d'Eddington
--------------------------------------------

À l'ordre 1 en harmoniques sphériques, l'intensité spécifique s'écrit :

$$I(\mathbf{r},\hat{\mathbf{n}},t)
\approx \frac{1}{4\pi}\left[\Phi(\mathbf{r},t) + 3\,\mathbf{J}(\mathbf{r},t)\cdot\hat{\mathbf{n}}\right]$$

La fonction de phase de Henyey–Greenstein tronquée à l'ordre 1 donne
$p \approx 1 + 3g(\hat{\mathbf{n}}'\cdot\hat{\mathbf{n}})$.
La **fermeture d'Eddington** associée est :

$$P_{ij} = \frac{\Phi}{3}\,\delta_{ij}$$

exacte pour un champ isotrope, avec une erreur d'ordre $O\!\left(\sqrt{\mu_a/\mu_s'}\right)$.

En injectant dans les équations de moments (voir :doc:`01_etablissement_etr`) :

$$\frac{1}{c}\frac{\partial\Phi}{\partial t} + \nabla\cdot\mathbf{J} + \mu_a\,\Phi = S$$

$$\frac{1}{c}\frac{\partial\mathbf{J}}{\partial t} + \frac{1}{3}\nabla\Phi + \mu_t'\,\mathbf{J} = \mathbf{0}$$

Loi de Fick et Équation de Diffusion
--------------------------------------

Dans le régime quasi-statique ($\frac{1}{c}\partial_t\mathbf{J} \ll \mu_t'\mathbf{J}$),
la deuxième équation donne la **loi de Fick** :

$$\mathbf{J}(\mathbf{r},t) = -D\,\nabla\Phi(\mathbf{r},t)$$

avec le **coefficient de diffusion** :

$$\boxed{D = \frac{1}{3(\mu_a+\mu_s')} = \frac{1}{3\,\mu_t'}}$$

En substituant dans l'équation d'énergie, on obtient l'**équation de diffusion** :

$$\boxed{\frac{1}{c}\frac{\partial\Phi}{\partial t} - \nabla\cdot(D\,\nabla\Phi) + \mu_a\,\Phi = S(\mathbf{r},t)}$$

En milieu homogène et en régime stationnaire, elle se réduit à l'équation de Helmholtz
modifiée $-D\,\nabla^2\Phi + \mu_a\,\Phi = S$, avec $k^2 = \mu_a/D$.

La **longueur de diffusion** est :

$$\delta = \sqrt{\frac{D}{\mu_a}} = \frac{1}{\sqrt{3\,\mu_a\,\mu_t'}}$$

Elle représente l'échelle de décroissance exponentielle de la fluence en l'absence de source.
Pour un tissu typique ($\mu_a = 0{,}1$ cm$^{-1}$, $\mu_s' = 10$ cm$^{-1}$) :
$\delta \approx 0{,}58$ cm.

Conditions aux Limites
-----------------------

L'approximation de diffusion ne peut pas imposer exactement la nullité du flux entrant
à l'interface. On la remplace par une **condition de Dirichlet extrapolée** au plan
$z = -z_b$ situé à l'extérieur du milieu :

$$\Phi\big|_{z=-z_b} = 0, \qquad z_b = 2\,A\,D$$

Le coefficient $A$ tient compte de la réflexion interne de Fresnel à l'interface
d'indice $n$ :

$$A = \frac{1+R_\phi}{1-R_J}, \quad
R_\phi = \int_0^{\pi/2}2\sin\theta\cos\theta\,R_F(\theta)\,d\theta, \quad
R_J    = \int_0^{\pi/2}3\sin\theta\cos^2\!\theta\,R_F(\theta)\,d\theta$$

Pour $n = 1{,}4$ (tissu) : $A \approx 3{,}84$, soit $z_b \approx 2{,}56\,D$.
Pour $n = 1$ (pas de désaccord d'indice) : $A = 1$, $z_b = 2D$.

Extension au Régime Fréquentiel
---------------------------------

Pour une source modulée à la pulsation $\omega$, la fluence s'écrit
$\Phi(\mathbf{r},t) = \tilde\Phi(\mathbf{r})\,e^{-j\omega t}$ et l'équation devient :

$$-D\,\nabla^2\tilde\Phi + \left(\mu_a+\frac{j\omega}{c}\right)\tilde\Phi = S_0(\mathbf{r})$$

avec le **coefficient d'atténuation effectif complexe** :

$$k(\omega) = \sqrt{\frac{\mu_a+j\omega/c}{D}}$$

dont la partie réelle donne l'atténuation spatiale et la partie imaginaire le déphasage.
En régime continu ($\omega = 0$) : $k_0 = 1/\delta$.

Domaine de Validité
--------------------

L'approximation de diffusion est valide si :

- $\mu_s' \gg \mu_a$ (typiquement un facteur 10)
- $r \gtrsim 3\,\ell^* = 3/\mu_t'$ (loin des sources et surfaces)
- $\omega \ll c\,\mu_t'$ (variation temporelle lente)

Elle est **invalide** au voisinage des sources ponctuelles ($r \lesssim \ell^*$),
des interfaces, des régions à forte absorption ($\mu_a \gtrsim \mu_s'$)
et des vides optiques. La méthode DOM (voir :doc:`10_dom_1d_sans_fluo`)
ne requiert pas ces hypothèses.

.. seealso::

   :doc:`04_da_1d_dipoles_sans_fluo` — résolution 1D par méthode des dipôles.

   :doc:`06_da_2d_dipoles_sans_fluo` — résolution 2D par méthode des dipôles.

   :doc:`08_da_2d_kienle_sans_fluo` — résolution 2D par fréquences spatiales.
