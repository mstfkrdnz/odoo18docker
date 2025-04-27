FROM python:3.10-slim

# Gerekli paketleri yükle
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libpq-dev \
    npm \
    node-less \
    && rm -rf /var/lib/apt/lists/*

# Odoo kaynak kodunu çek
RUN git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git /opt/odoo

# Kendi düzenlediğimiz requirements.txt dosyamızı kopyala ve Odoo'nun requirements dosyasının üstüne yaz
COPY requirements.txt /opt/odoo/requirements.txt

# Requirements dosyasını yükle
# RUN pip install --upgrade pip && pip install -r /opt/odoo/requirements.txt
RUN pip install --no-cache-dir -r /opt/odoo/requirements.txt

# Çalışma dizini
WORKDIR /opt/odoo

# Ortam değişkenleri
ENV HOST 0.0.0.0
ENV PORT 8069

# Odoo başlat
CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
