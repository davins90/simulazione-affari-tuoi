FROM jupyter/scipy-notebook:python-3.11

# Passa a root per impostare permessi e directory
USER root

# Crea la cartella di lavoro persistente e assegna i permessi all'utente jovyan
RUN mkdir -p /home/jovyan/workbench && chown jovyan:users /home/jovyan/workbench

# Torna all'utente jovyan
USER jovyan

WORKDIR /home/jovyan/workbench

# Copia i requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Abilita JupyterLab
ENV JUPYTER_ENABLE_LAB=yes

# Espone la porta di Jupyter
EXPOSE 8888

# Avvia usando start-notebook.py invece di start-notebook.sh,
# e usa --ServerApp.token='' invece di --NotebookApp.token=''
CMD ["start-notebook.py", "--ServerApp.token=''"]