Extension à la Fluorescence — Couple d'ETR
==========================================

Introduction
------------

La **fluorescence** est le phénomène par lequel un fluorophore absorbe un photon à la
longueur d'onde d'**excitation** $\lambda_x$ et réémet un photon à la longueur d'onde
d'**émission** $\lambda_m > \lambda_x$ (décalage de Stokes), après un temps de vie
moyen $\tau_f$. En imagerie optique diffuse fluorescente (FDOT), on cherche à
reconstruire la distribution spatiale de fluorophores à partir des mesures de surface.

Ce phénomène couple deux champs radiatifs — excitation et émission — via un terme
source fluorescent. Il faut donc résoudre un **système de deux ETR couplées**.

Notations
---------

On note $I_x$ et $I_m$ les intensités spécifiques aux longueurs d'onde d'excitation
et d'émission, $\kappa_x, \sigma_x$ et $\kappa_m, \sigma_m$ les coefficients
d'absorption et de diffusion du milieu à chaque longueur d'onde, $\mu_{af}(\mathbf{r})$
le coefficient d'absorption du fluorophore à $\lambda_x$, $\eta \in [0,1]$ le rendement
quantique et $\tau_f$ le temps de vie de fluorescence.

Physique du Fluorophore
------------------------

Le processus se déroule en trois étapes : **(1)** absorption d'un photon d'excitation
(transition $S_0 \to S_1^*$), **(2)** relaxation vibrationnelle non radiative
(picosecondes) vers le bas de $S_1$, **(3)** émission spontanée d'un photon de
fluorescence à $\lambda_m > \lambda_x$ avec un taux radiatif $k_r = \eta/\tau_f$.

Le terme source de fluorescence émis par unité de volume, de temps et d'angle solide est :

$$q_m(\mathbf{r},\hat{\mathbf{n}},t)
= \frac{\eta\,\mu_{af}(\mathbf{r})}{4\pi}
\int_{-\infty}^{t} \frac{e^{-(t-t')/\tau_f}}{\tau_f}\,\Phi_x(\mathbf{r},t')\,dt'$$

où $\Phi_x = \int I_x\,d\Omega$ est la fluence d'excitation. La convolution temporelle
avec $e^{-t/\tau_f}/\tau_f$ traduit l'émission exponentielle du fluorophore.
En régime continu (CW), elle se simplifie en $q_m^\text{CW} = \frac{\eta\,\mu_{af}}{4\pi}\Phi_x$.

Le Système de Deux ETR Couplées
---------------------------------

**ETR d'excitation.** Le fluorophore contribue à l'absorption totale :
$\kappa_x^\text{tot} = \kappa_x + \mu_{af}$. L'ETR d'excitation est donc :

.. math::

	\frac{1}{c}\frac{\partial I_x}{\partial t}
	+ \hat{\mathbf{n}}\cdot\nabla I_x
	= -(\kappa_x^\text{tot}+\sigma_x)\,I_x
	+ \kappa_x\,B_x(T)
	+ \sigma_x\int_{4\pi} p_x\,I_x'\,\frac{d\Omega'}{4\pi}
	+ S_x(\mathbf{r},\hat{\mathbf{n}},t)

**ETR d'émission.** Elle est pilotée par le terme source fluorescent $q_m$ :

$$\frac{1}{c}\frac{\partial I_m}{\partial t}
+ \hat{\mathbf{n}}\cdot\nabla I_m
= -(\kappa_m+\sigma_m)\,I_m
+ \sigma_m\int_{4\pi} p_m\,I_m'\,\frac{d\Omega'}{4\pi}
+ \frac{\eta\,\mu_{af}(\mathbf{r})}{4\pi}
\int_{-\infty}^{t}\frac{e^{-(t-t')/\tau_f}}{\tau_f}\,\Phi_x(\mathbf{r},t')\,dt'$$

.. note::

   Le couplage est **unidirectionnel** : l'excitation pilote l'émission, mais l'émission
   ne rétroagit pas sur l'excitation (hypothèse de faible conversion). Les deux ETR se
   résolvent donc **séquentiellement** — d'abord $I_x$, puis $I_m$.

Approximation de Diffusion Appliquée
--------------------------------------

Dans le régime diffusif ($\mu_s' \gg \mu_a$, $r \gg \ell^*$), chaque ETR se réduit à
une équation de diffusion (voir :doc:`03_approximation_diffusion`). Le système devient :

**Équation de diffusion d'excitation :**

$$\boxed{-\nabla\cdot(D_x\,\nabla\Phi_x) + (\mu_{ax}+\mu_{af})\,\Phi_x = S_x(\mathbf{r})}$$

avec $D_x = 1/[3(\mu_{ax}+\mu_{af}+\mu_{sx}')]$.

**Équation de diffusion d'émission (CW) :**

$$\boxed{-\nabla\cdot(D_m\,\nabla\Phi_m) + \mu_{am}\,\Phi_m = \eta\,\mu_{af}(\mathbf{r})\,\Phi_x(\mathbf{r})}$$

**Équation de diffusion d'émission (temporel) :**

$$\frac{1}{c}\frac{\partial\Phi_m}{\partial t}
- \nabla\cdot(D_m\,\nabla\Phi_m) + \mu_{am}\,\Phi_m
= \frac{\eta\,\mu_{af}}{\tau_f}\int_{-\infty}^{t} e^{-(t-t')/\tau_f}\,\Phi_x(\mathbf{r},t')\,dt'$$

Domaine Fréquentiel
--------------------

Pour une source modulée à la pulsation $\omega$, les composantes modulées
$\tilde\Phi_x$ et $\tilde\Phi_m$ vérifient :

$$-\nabla\cdot(D_x\nabla\tilde\Phi_x) + \left(\mu_{ax}^\text{tot}+\frac{j\omega}{c}\right)\tilde\Phi_x = \tilde S_x$$

$$-\nabla\cdot(D_m\nabla\tilde\Phi_m) + \left(\mu_{am}+\frac{j\omega}{c}\right)\tilde\Phi_m
= \frac{\eta\,\mu_{af}}{1+j\omega\tau_f}\,\tilde\Phi_x$$

Le facteur $(1+j\omega\tau_f)^{-1}$ encode le **déphasage** introduit par le temps de
vie, exploitable pour discriminer des fluorophores de durées de vie différentes.

Paramètres Mesurables et Problème Inverse
------------------------------------------

En FDOT, on mesure en surface le flux d'émission $\Phi_m|_{\partial\Omega}$ pour
différentes configurations source/détecteur. Selon la modalité :

- **CW** : on reconstruit $\eta\,\mu_{af}(\mathbf{r})$ (produit non séparable).
- **FD** : l'amplitude et la phase de $\tilde\Phi_m$ permettent de séparer $\mu_{af}(\mathbf{r})$ et $\tau_f(\mathbf{r})$.
- **TD** : la TPSF de fluorescence donne accès à $\mu_{af}(\mathbf{r})$, $\eta$ et $\tau_f(\mathbf{r})$ séparément.

.. seealso::

   :doc:`01_etablissement_etr` — forme générale de l'ETR dont ce système est dérivé.

   :doc:`05_da_1d_dipoles_avec_fluo` — résolution 1D de ce système par méthode des dipôles.

   :doc:`07_da_2d_dipoles_avec_fluo` — résolution 2D par méthode des dipôles.

   :doc:`09_da_2d_kienle_avec_fluo` — résolution 2D par passage en fréquences spatiales.
