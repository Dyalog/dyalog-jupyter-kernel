import sys
from ipykernel.kernelapp import IPKernelApp
from . import DyalogKernel
from .install import install_kernel_spec

def main():
    if len(sys.argv) > 1 and sys.argv[1] == 'install':
        install_kernel_spec()
    else:
        IPKernelApp.launch_instance(kernel_class=DyalogKernel)

if __name__ == '__main__':
    main()
