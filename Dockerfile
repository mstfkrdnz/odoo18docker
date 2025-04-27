FROM python:3.10-slim

# Sistem bağımlılıklarını yükle
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libpq-dev \
    node-less \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Odoo kaynak kodunu al
RUN git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git /opt/odoo

# Çalışma dizini
WORKDIR /opt/odoo

# Gereksinimleri yükle
RUN pip install -r requirements.txt

# Ortam değişkenleri
ENV HOST 0.0.0.0
ENV PORT 8069

# Odoo'yu çalıştır
CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
