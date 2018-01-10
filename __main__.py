from ipykernel.kernelapp import IPKernelApp
from . import DyalogKernel

IPKernelApp.launch_instance(kernel_class=DyalogKernel)
