import matplotlib.pyplot
import numpy

class Simulator(object):
    gamma = 267522187.44 # rad/s/T
    gamma_bar = 42577478.518 # Hz/T
        
    def __init__(self, M0, T1, T2, positions, delta_omega=None):
        M0, T1, T2, positions = [
            numpy.asarray(x) for x in [M0, T1, T2, positions]]
        
        if delta_omega is None:
            delta_omega = numpy.zeros(M0.shape)
        else:
            delta_omega = numpy.asarray(delta_omega)
        
        if any(x.ndim != 1 for x in [T1, T2, delta_omega]):
            raise Exception("M0, T1, T2, and delta_omega must be 1D")
        if any(M0.shape != x.shape for x in [T1, T2, delta_omega]):
            raise Exception("All inputs must be have the same size")
        if M0.shape != positions.shape[:1]:
            raise Exception("All inputs must be have the same size")
        
        self.M0 = numpy.array(M0)
        self._magnetization = numpy.zeros((len(M0), 4))
        self._magnetization[:, 2] = M0
        self._magnetization[:, 3] = 1
        
        self.T1 = numpy.array(T1)
        self.T2 = numpy.array(T2)
        self.positions = numpy.array(positions)
        self.delta_omega = delta_omega
    
    @property
    def magnetization(self):
        # NOTE: self.M[:, 3] will always be one
        return self._magnetization[:,:3] / self._magnetization[:,3:]
    
    def pulse(self, angle, phase=None):
        angle = numpy.atleast_1d(angle)
        phase = (
            numpy.atleast_1d(phase)
            if phase is not None else numpy.zeros_like(angle))
        operator = numpy.zeros((*angle.shape, 4, 4))
        operator[:, :3, :3] = numpy.array([
            compute_rotation_matrix([numpy.cos(p), numpy.sin(p), 0], a)
            for a, p in zip(angle, phase)])
        operator[:, 3, 3] = 1
        
        self._magnetization = numpy.einsum(
            "nij,nj->ni", operator, self._magnetization)
    
    def free_precession(self, duration):
        operator = precession(self.delta_omega, duration)
        self._magnetization = numpy.einsum(
            "nij,nj->ni", operator, self._magnetization)
    
    def relaxation(self, duration):
        operator = relaxation(self.M0, self.T1, self.T2, duration)
        self._magnetization = numpy.einsum(
            "nij,nj->ni", operator, self._magnetization)
    
    def idle(self, duration):
        op1 = relaxation(self.M0, self.T1, self.T2, duration)
        op2 = precession(self.delta_omega, duration)
        operator = op2 @ op1
        self._magnetization = numpy.einsum(
            "nij,nj->ni", operator, self._magnetization)
    
    def gradient(self, amplitude, duration):
        op1 = relaxation(self.M0, self.T1, self.T2, duration)
        
        delta_B = numpy.dot(self.positions, numpy.array(amplitude))
        delta_omega = self.gamma_bar * delta_B
        op2 = precession(delta_omega+self.delta_omega, duration)
        
        operator = op2 @ op1
        self._magnetization = numpy.einsum(
            "nij,nj->ni", operator, self._magnetization)

def precession(delta_omega, duration):
    angle = 2*numpy.pi*duration*delta_omega
    
    operator = numpy.zeros((*angle.shape, 4, 4))
    operator[:, :3, :3] = numpy.array(
        [compute_rotation_matrix([0, 0, 1], x) for x in angle])
    operator[:, 3, 3] = 1
    
    return operator

def relaxation(M0, T1, T2, duration):
    E1 = numpy.exp(-duration/T1)
    E2 = numpy.exp(-duration/T2)
    
    operator = numpy.zeros((len(T1), 4, 4))
    operator[:, 0, 0] = E2
    operator[:, 1, 1] = E2
    operator[:, 2, 2] = E1
    operator[:, 3, 3] = 1
    operator[:, 2, 3] = M0*(1-E1)
    
    return operator

def compute_rotation_matrix(k, theta):
    """ Return the matrix corresponding to the rotation around
        axis k by an angle theta (in radians).
    """
    
    K = numpy.array([
        [0, -k[2], k[1]],
        [k[2], 0, -k[0]],
        [-k[1], k[0], 0],
    ])
    R = (
        numpy.identity(3)
        + K*numpy.sin(theta)
        + numpy.linalg.matrix_power(K, 2) * (1-numpy.cos(theta)))
    return R
