FROM rocker/rstudio:4.1.3
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_version('renv', version='0.15.4')"
WORKDIR /home/rstudio/sleep_deprivation/
COPY . .
RUN chown -R rstudio:rstudio /home/rstudio/
ENV RENV_PATHS_CACHE /home/rstudio/.cache/R/renv
RUN R --no-init-file -e "renv::restore()"

