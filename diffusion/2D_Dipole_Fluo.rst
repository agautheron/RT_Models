Diffusion & Fluorescence
========================

*Section author:* Équipe

Cette section présente la résolution des équations de diffusion couplées
pour la propagation de la lumière et la fluorescence dans un milieu
biologique semi-infini, par la **méthode des dipôles**.

----

Système d'équations couplées
-----------------------------

Le problème complet est décrit par deux équations de diffusion couplées.
L'équation d'excitation à :math:`\lambda_x` :

.. math::

   D_x \left(\frac{\partial^2 \phi_x}{\partial x^2}
            + \frac{\partial^2 \phi_x}{\partial y^2}
            + \frac{\partial^2 \phi_x}{\partial z^2}\right)
   - \mu_{a,x}\,\phi_x
   = -\mu_{s,x}\,\phi_{r,x}(x,y,z)

L'équation d'émission de fluorescence à :math:`\lambda_m` :

.. math::

   D_m \left(\frac{\partial^2 \phi_m}{\partial x^2}
            + \frac{\partial^2 \phi_m}{\partial y^2}
            + \frac{\partial^2 \phi_m}{\partial z^2}\right)
   - \mu_{a,m}\,\phi_m
   = -Y\,\mu_{a,d,x}\!\left[\phi_{r,x}(x,y,z) + \phi_x(x,y,z)\right]

où :math:`\phi_x` est la fluence d'excitation, :math:`\phi_m` la fluence
d'émission, :math:`\phi_{r,x}` le terme balistique (faisceau non diffusé),
:math:`D_{x,m} = 1/(3\mu_{t,x,m})` les coefficients de diffusion,
:math:`\mu_{a,d,x}` l'absorption du fluorophore seul à :math:`\lambda_x`,
et :math:`Y` le rendement quantique.

Le couplage est **unidirectionnel** : l'équation d'excitation est indépendante
et se résout en premier ; sa solution alimente ensuite l'équation d'émission.

Paramètres dérivés
-------------------

Les coefficients de transport et d'atténuation effectifs sont :

.. math::

   \mu_{t,x} = \mu_{a,x} + \mu_{s,x}, \qquad
   \mu_{t,m} = \mu_{a,m} + \mu_{s,m}

.. math::

   \mu_{\mathrm{eff},x} = \sqrt{3\,\mu_{a,x}\,\mu_{t,x}}, \qquad
   \mu_{\mathrm{eff},m} = \sqrt{3\,\mu_{a,m}\,\mu_{t,m}}

Les conditions aux limites extrapolées (indice :math:`n \approx 1.4`,
réflectance interne diffuse :math:`R_d \approx 0.493`) donnent :

.. math::

   A = \frac{1 + R_d}{1 - R_d}, \qquad
   z_{b,x} = 2\,A\,D_x, \qquad
   z_{b,m} = 2\,A\,D_m

----

Étape 1 — Résolution de :math:`\phi_x`
----------------------------------------

Approximation dipôlaire
~~~~~~~~~~~~~~~~~~~~~~~~

Le terme balistique :math:`\phi_{r,x}` est modélisé comme une source
ponctuelle (dipôle) localisée à la profondeur :math:`z_{0,x} = 1/\mu_{t,x}`.
C'est l'approximation centrale de la **méthode des dipôles**.

Solution dans le milieu semi-infini
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La solution de l'équation de diffusion dans un milieu semi-infini avec
condition aux limites de Dirichlet extrapolée en :math:`z = -z_{b,x}` est :

.. math::

   \phi_x(\rho, z)
   = \frac{3\,\mu_{s,x}}{4\pi}
     \left(
       \frac{e^{-\mu_{\mathrm{eff},x}\,r_{1,x}}}{r_{1,x}}
     - \frac{e^{-\mu_{\mathrm{eff},x}\,r_{2,x}}}{r_{2,x}}
     \right)

avec les distances dipôle réel / dipôle image :

.. math::

   r_{1,x} = \sqrt{\rho^2 + (z - z_{0,x})^2}, \qquad
   r_{2,x} = \sqrt{\rho^2 + (z + z_{0,x} + 2\,z_{b,x})^2}

Réflectance d'excitation
~~~~~~~~~~~~~~~~~~~~~~~~~

La réflectance mesurée en surface est :math:`R_x(\rho) = -D_x\,\partial_z\phi_x|_{z=0}` :

.. math::

   R_x(\rho)
   = \frac{3\,\mu_{s,x}}{4\pi}
     \left[
       \frac{z_{0,x}}{r_{1,x}^3}\left(1 + \mu_{\mathrm{eff},x}\,r_{1,x}\right)
       e^{-\mu_{\mathrm{eff},x}\,r_{1,x}}
     + \frac{z_{0,x} + 2\,z_{b,x}}{r_{2,x}^3}\left(1 + \mu_{\mathrm{eff},x}\,r_{2,x}\right)
       e^{-\mu_{\mathrm{eff},x}\,r_{2,x}}
     \right]

où les distances sont évaluées en :math:`z = 0`.

.. solution::

   La dérivée de :math:`e^{-\mu r}/r` par rapport à :math:`z` en :math:`z=0`
   s'obtient par la règle de dérivation en chaîne :

   .. math::

      \frac{\partial}{\partial z}\frac{e^{-\mu_{\mathrm{eff}} r}}{r}
      = -\frac{(z - z_0)}{r^3}\left(1 + \mu_{\mathrm{eff}}\,r\right)
        e^{-\mu_{\mathrm{eff}} r}

   En :math:`z=0`, le terme du dipôle réel donne un facteur :math:`-(-z_0)/r^3 = z_0/r^3`,
   et le dipôle image donne :math:`(z_0 + 2z_b)/r^3` (car le dipôle image est
   en :math:`-(z_0 + 2z_b)`). Le signe moins de :math:`-D_x\partial_z`
   se combine avec le signe de la dérivée pour donner des termes positifs.

----

Étape 2 — Résolution de :math:`\phi_m`
----------------------------------------

Par linéarité, on décompose :math:`\phi_m = \phi_m^{(1)} + \phi_m^{(2)}`,
chaque terme correspondant à l'une des deux sources du membre de droite.

Fonction de Green du milieu d'émission
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La fonction de Green :math:`G_m` du milieu semi-infini à :math:`\lambda_m` est :

.. math::

   G_m(\rho, z, z_0)
   = \frac{1}{4\pi}
     \left(
       \frac{e^{-\mu_{\mathrm{eff},m}\,r_{1,m}}}{r_{1,m}}
     - \frac{e^{-\mu_{\mathrm{eff},m}\,r_{2,m}}}{r_{2,m}}
     \right)

avec :math:`r_{1,m} = \sqrt{\rho^2 + (z-z_0)^2}` et
:math:`r_{2,m} = \sqrt{\rho^2 + (z+z_0+2z_{b,m})^2}`.

Sa dérivée en :math:`z = 0`, utilisée pour calculer la réflectance, est :

.. math::

   \frac{\partial G_m}{\partial z}\bigg|_{z=0}
   = \frac{1}{4\pi}
     \left[
       \frac{z_0}{r_{1,m}^3}\left(1 + \mu_{\mathrm{eff},m}\,r_{1,m}\right)
       e^{-\mu_{\mathrm{eff},m}\,r_{1,m}}
     + \frac{z_0 + 2\,z_{b,m}}{r_{2,m}^3}\left(1 + \mu_{\mathrm{eff},m}\,r_{2,m}\right)
       e^{-\mu_{\mathrm{eff},m}\,r_{2,m}}
     \right]

:math:`\phi_m^{(1)}` — Source balistique :math:`\phi_{r,x}`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

L'équation à résoudre est :

.. math::

   D_m\,\nabla^2\phi_m^{(1)} - \mu_{a,m}\,\phi_m^{(1)}
   = -Y\,\mu_{a,d,x}\,\phi_{r,x}(\mathbf{r})

Le terme balistique étant approché par un Dirac en :math:`z_{0,x}`,
la solution est directement donnée par la fonction de Green :

.. math::

   \phi_m^{(1)}(\rho, z)
   = \frac{Y\,\mu_{a,d,x}}{D_m}\,G_m(\rho, z, z_{0,x})

La réflectance associée :math:`R_m^{(1)}(\rho) = -D_m\,\partial_z\phi_m^{(1)}|_{z=0}` est :

.. math::

   R_m^{(1)}(\rho)
   = \frac{Y\,\mu_{a,d,x}}{4\pi}
     \left[
       \frac{z_{0,x}}{r_{1,x}^3}\left(1 + \mu_{\mathrm{eff},m}\,r_{1,x}\right)
       e^{-\mu_{\mathrm{eff},m}\,r_{1,x}}
     + \frac{z_{0,x} + 2\,z_{b,m}}{r_{2,x}^3}\left(1 + \mu_{\mathrm{eff},m}\,r_{2,x}\right)
       e^{-\mu_{\mathrm{eff},m}\,r_{2,x}}
     \right]

.. note::

   Les distances :math:`r_{1,x}` et :math:`r_{2,x}` sont calculées avec la
   profondeur source :math:`z_{0,x}` (propriétés d'excitation), mais
   :math:`\mu_{\mathrm{eff},m}` et :math:`z_{b,m}` sont les paramètres
   d'émission. Le subscript *x* désigne l'origine de la source, non le milieu
   de propagation.

:math:`\phi_m^{(2)}` — Source diffuse :math:`\phi_x`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

L'équation à résoudre est :

.. math::

   D_m\,\nabla^2\phi_m^{(2)} - \mu_{a,m}\,\phi_m^{(2)}
   = -Y\,\mu_{a,d,x}\,\phi_x(\rho, z)

La source :math:`\phi_x` est un champ volumique étendu. La solution est la
**convolution** de :math:`\phi_x` avec :math:`G_m` :

.. math::

   \phi_m^{(2)}(\rho, z)
   = \frac{Y\,\mu_{a,d,x}}{D_m}
     \int_0^{\infty} \phi_x(\rho, z')\,G_m(\rho, z, z')\,dz'

En substituant l'expression de :math:`\phi_x` :

.. math::

   \phi_m^{(2)}(\rho, z)
   = \frac{Y\,\mu_{a,d,x}}{D_m}
     \cdot \frac{3\,\mu_{s,x}}{(4\pi)^2}
     \int_0^{\infty}
     \underbrace{\left(
       \frac{e^{-\mu_{\mathrm{eff},x}\,\tilde{r}_1}}{\tilde{r}_1}
     - \frac{e^{-\mu_{\mathrm{eff},x}\,\tilde{r}_2}}{\tilde{r}_2}
     \right)}_{\phi_x \;\text{normalisé}}
     \underbrace{\left(
       \frac{e^{-\mu_{\mathrm{eff},m}\,r_{1,m}}}{r_{1,m}}
     - \frac{e^{-\mu_{\mathrm{eff},m}\,r_{2,m}}}{r_{2,m}}
     \right)}_{4\pi\,G_m}
     dz'

avec :

.. math::

   \tilde{r}_1 = \sqrt{\rho^2 + (z' - z_{0,x})^2}, \qquad
   \tilde{r}_2 = \sqrt{\rho^2 + (z' + z_{0,x} + 2\,z_{b,x})^2}

La réflectance :math:`R_m^{(2)}(\rho) = -D_m\,\partial_z\phi_m^{(2)}|_{z=0}` est :

.. math::

   R_m^{(2)}(\rho)
   = \frac{Y\,\mu_{a,d,x}\cdot 3\,\mu_{s,x}}{(4\pi)^2}
     \int_0^{\infty}
     \left(
       \frac{e^{-\mu_{\mathrm{eff},x}\,\tilde{r}_1}}{\tilde{r}_1}
     - \frac{e^{-\mu_{\mathrm{eff},x}\,\tilde{r}_2}}{\tilde{r}_2}
     \right)
     \frac{\partial G_m}{\partial z}\bigg|_{z=0}
     dz'

.. solution::

   Contrairement à :math:`\phi_m^{(1)}`, cette intégrale **n'admet pas de
   forme analytique fermée**. La source :math:`\phi_x(z')` décroît en
   :math:`e^{-\mu_{\mathrm{eff},x}\,r}/r`, qui n'est pas une exponentielle
   simple en :math:`z'` : on ne peut donc pas appliquer l'approximation Dirac.
   L'intégrale est calculée **numériquement** (méthode des trapèzes sur une
   grille :math:`z' \in [0,\; 10/\mu_{\mathrm{eff},x}]`).

----

Réflectance totale de fluorescence
------------------------------------

La réflectance totale est la somme des deux contributions :

.. math::

   R_m(\rho) = R_m^{(1)}(\rho) + R_m^{(2)}(\rho)

:math:`R_m^{(1)}` est analytique (forme fermée) et :math:`R_m^{(2)}` est
calculée numériquement.

----

Inner Filter Effect (IFE)
---------------------------

L'IFE introduit une atténuation supplémentaire liée à l'absorption du
fluorophore lui-même sur le trajet des photons.

IFE primaire
~~~~~~~~~~~~~

Le faisceau d'excitation est atténué avant d'atteindre la profondeur :math:`z'` :

.. math::

   \eta_{\mathrm{prim}}(z') = e^{-\mu_{\mathrm{ife},x}\,z'}

où :math:`\mu_{\mathrm{ife},x}` est l'absorption du fluorophore seul à :math:`\lambda_x`.

IFE secondaire
~~~~~~~~~~~~~~~

Le photon d'émission est réabsorbé sur son chemin vers la surface,
approximé par la distance géométrique :math:`\sqrt{z'^2 + \rho^2}` :

.. math::

   \eta_{\mathrm{sec}}(\rho, z') = e^{-\mu_{\mathrm{ife},m}\,\sqrt{z'^2 + \rho^2}}

Facteur IFE combiné
~~~~~~~~~~~~~~~~~~~~

.. math::

   \eta_{\mathrm{IFE}}(\rho, z')
   = \eta_{\mathrm{prim}}(z') \cdot \eta_{\mathrm{sec}}(\rho, z')
   = e^{-\mu_{\mathrm{ife},x}\,z'}
     \cdot e^{-\mu_{\mathrm{ife},m}\,\sqrt{z'^2 + \rho^2}}

Réflectances corrigées par l'IFE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pour :math:`R_m^{(1)}`, le facteur IFE est évalué en :math:`z' = z_{0,x}` :

.. math::

   R_m^{(1),\mathrm{IFE}}(\rho)
   = e^{-\mu_{\mathrm{ife},x}\,z_{0,x}}
     \cdot e^{-\mu_{\mathrm{ife},m}\,\sqrt{z_{0,x}^2 + \rho^2}}
     \cdot R_m^{(1)}(\rho)

Pour :math:`R_m^{(2)}`, le facteur IFE est intégré directement dans
l'intégrande numérique :

.. math::

   R_m^{(2),\mathrm{IFE}}(\rho)
   = \frac{Y\,\mu_{a,d,x}\cdot 3\,\mu_{s,x}}{(4\pi)^2}
     \int_0^{\infty}
     \eta_{\mathrm{IFE}}(\rho, z')
     \left(
       \frac{e^{-\mu_{\mathrm{eff},x}\,\tilde{r}_1}}{\tilde{r}_1}
     - \frac{e^{-\mu_{\mathrm{eff},x}\,\tilde{r}_2}}{\tilde{r}_2}
     \right)
     \frac{\partial G_m}{\partial z}\bigg|_{z=0}
     dz'

----

Extension spectrale
--------------------

Pour des propriétés optiques spectrales :math:`\mu_a(\lambda)`,
:math:`\mu_s'(\lambda)`, tous les paramètres dérivés deviennent des fonctions
de :math:`\lambda`. Les réflectances mesurées sont obtenues par intégration
spectrale avec les poids :math:`S(\lambda)` (spectre source),
:math:`E(\lambda_m)` (spectre d'émission du fluorophore) et
:math:`Q(\lambda)` (efficacité quantique du détecteur) :

.. math::

   R_{x,\mathrm{mes}}(\rho)
   = \frac{\displaystyle\int S(\lambda)\,Q(\lambda)\,R_x(\rho,\lambda)\,d\lambda}
          {\displaystyle\int S(\lambda)\,Q(\lambda)\,d\lambda}

.. math::

   R_{m,\mathrm{mes}}(\rho)
   = \frac{\displaystyle\int S(\lambda_x)\,E(\lambda_m)\,Q(\lambda_m)\,
           R_m(\rho,\lambda_x,\lambda_m)\,d\lambda_x\,d\lambda_m}
          {\displaystyle\int S(\lambda_x)\,E(\lambda_m)\,Q(\lambda_m)\,
           d\lambda_x\,d\lambda_m}

.. note::

   Le détecteur QEPro (Ocean Insight) embarque le CCD Hamamatsu S7031-1006
   (back-thinned), avec un pic de QE d'environ 92 % à 580 nm et une plage
   spectrale de 200 à 1100 nm. La courbe :math:`Q(\lambda)` exacte de chaque
   instrument est fournie dans le fichier de calibration livré avec l'appareil.
