FROM python:3.12-slim

# Tipografías equivalentes a Arial / Times New Roman / Calibri / Cambria
RUN apt-get update && apt-get install -y --no-install-recommends \
        fonts-liberation fonts-crosextra-carlito fonts-crosextra-caladea fonts-dejavu-core \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user PATH=/home/user/.local/bin:$PATH MPLBACKEND=Agg PORT=7860
WORKDIR /home/user/app

# Todo el programa viene dentro de codigo.zip (se descomprime aquí)
COPY --chown=user codigo.zip .
RUN python -c "import zipfile; zipfile.ZipFile('codigo.zip').extractall('.')" \
    && pip install --no-cache-dir -r requirements.txt

EXPOSE 7860
CMD ["python", "main.py"]
