# pull the elyra notebook image
FROM quay.io/thoth-station/s2i-lab-elyra:latest
# switch to root user
USER root 
# silent download and install nvidia container toolkit
RUN curl -s -L https://nvidia.github.io/nvidia-docker/rhel8.3/nvidia-docker.repo | tee /etc/yum.repos.d/nvidia-docker.repo
# install nvidia container toolkig
RUN yum clean expire-cache 
RUN yum install -y nvidia-container-toolkit
# verify hook added
RUN cat  /usr/share/containers/oci/hooks.d/oci-nvidia-hook.json
# setup rootless container
RUN sed -i 's/^#no-cgroups = false/no-cgroups = true/;' /etc/nvidia-container-runtime/config.toml
# switch out of root
USER 1001