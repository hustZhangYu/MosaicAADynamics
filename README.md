# Mosaic AA Dynamics
In this study, we explore the dynamics of the Mosaic AA model, focusing on the construction of its effective Hamiltonian. Our primary goal is to analyze the underlying physical properties through numerical simulations, and to derive a better understanding of the model’s behavior under various conditions.

## Numerical Results
This section presents the numerical simulations that were conducted, which highlight key properties of the Mosaic AA model. We examine wavepacket dynamics, particle distributions, and the mobility edge.

### Mosaic AA Model

#### Mobility Edge
The **mobility edge** is a critical concept in understanding the transition between localized and extended states in disordered systems. In the Mosaic AA model, we observe the following:

- **Extended Phase**: In this phase, the wavefunctions are extended throughout the system. The system exhibits metallic-like behavior where charge transport is possible.
  
- **Localized Phase**: In contrast, the localized phase corresponds to states where wavefunctions are spatially confined, leading to an absence of transport.
  
- **Critical Points**: The boundary between the localized and extended phases marks the mobility edge. The position of this edge can depend on parameters such as disorder strength or system size.

The **mobility edge** can be examined through both numerical simulations and analytical approaches, where we look at the density of states and scaling behavior near the critical point.

#### Extended Proportion
The **extended proportion** refers to the fraction of extended states within the system. This quantity helps characterize the nature of the system as it undergoes transitions:

- As we increase the disorder strength or change system parameters, the number of extended states typically decreases.
- The **phase diagram** of the Mosaic AA model can be plotted to show how the extended proportion changes with respect to parameters like disorder strength and energy.

### Wavepacket Dynamics

#### Time Evolution of the Wavepacket
Wavepacket dynamics can be studied by solving the time-dependent Schrödinger equation:

$$
\[
\frac{d}{dt} \Psi(x,t) = \hat{H} \Psi(x,t)
\]
$$

Where \( \hat{H} \) is the Hamiltonian operator for the system, and \( \Psi(x,t) \) is the wavefunction at position \(x\) and time \(t\).

- **Initial Conditions**: We typically start with a Gaussian wavepacket localized at some position \(x_0\).
  
- **Propagation**: The time evolution shows how the wavepacket spreads or remains localized, which is crucial for understanding transport properties.

#### Time Evolution of \( \langle x^2 \rangle \)
The time evolution of the mean squared displacement, \( \langle x^2 \rangle \), is an important quantity in studying the spreading of the wavepacket. It is given by:

$$
\[
\langle x^2 \rangle (t) = \int x^2 |\Psi(x,t)|^2 dx
\]
$$
- In the **extended phase**, the wavepacket spreads diffusively, leading to a linear increase in \( \langle x^2 \rangle \) over time.
- In the **localized phase**, the wavepacket remains confined, and \( \langle x^2 \rangle \) shows little or no growth.

This behavior helps differentiate between extended and localized states.

### Particle Number Distribution

#### Imbalance
The particle number imbalance is an indicator of the distribution of particles across different parts of the system. This imbalance arises when the system is driven out of equilibrium.

- **Particle Imbalance** can be quantified as the difference in particle density between two regions of the system:
  
\[
I = \frac{N_L - N_R}{N_L + N_R}
\]

Where \(N_L\) and \(N_R\) are the number of particles in the left and right regions, respectively.

#### Particle Distribution
We also examine the spatial distribution of particles in the system. This can provide insight into the localization or delocalization of the particles.

- **Disordered Systems**: In disordered systems, the particle distribution can show inhomogeneity due to the localization effects.
  
- **Transport Properties**: By analyzing the particle distribution over time, we can draw conclusions about the transport properties of the system.

## Effective Hamiltonian

The **effective Hamiltonian** is constructed to describe the dynamics of the system. It captures the relevant degrees of freedom in the system and allows us to study the system's behavior more efficiently.

### Spectrum and IPR for Eigenvalues
The spectrum of the effective Hamiltonian gives us the energy eigenvalues of the system, which are crucial for understanding the system's behavior at different energy scales. The **Inverse Participation Ratio (IPR)** is often used to characterize the eigenstates:

- **Localized States**: High IPR values are associated with localized states, where the wavefunction is confined to a small region.
- **Extended States**: Low IPR values indicate extended states, where the wavefunction is spread over the entire system.

We calculate the **IPR** for different eigenstates.

### Finite Size Scaling
In finite systems, the results can be affected by the system size. Finite size scaling is used to extrapolate results obtained from small systems to the thermodynamic limit.
- **Scaling Behavior**: We study how physical quantities like IPR change as we increase the system size.


## Reply Codes
In this section, we provide code snippets that address questions raised by the referees during the review process. These codes are focused on:
- **Additional Simulations**: Addressing any additional simulations or analyses requested by the reviewers.



