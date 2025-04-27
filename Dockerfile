FROM python:3.10-slim

# Gerekli sistem paketlerini yükle
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libpq-dev \
    curl \
    npm \
    node-less \
    && rm -rf /var/lib/apt/lists/*

# 1. Odoo kaynak kodunu resmi repodan çekiyoruz
RUN git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git /opt/odoo

# 2. Senin GitHub repondan requirements.txt dosyasını geçici bir yere indiriyoruz
# Burada URL'yi senin doğru dosya URL'inle değiştireceğiz
RUN curl -o /tmp/requirements.txt https://raw.githubusercontent.com/mstfkrdnz/odoo18docker/main/requirements.txt

# 3. Geçici yere indirdiğimiz dosyayla orijinal requirements.txt'yi değiştiriyoruz
RUN cp /tmp/requirements.txt /opt/odoo/requirements.txt

# 4. pip install
RUN pip install --upgrade pip
RUN pip install "gevent>=22.10.2"
RUN pip install --no-cache-dir -r /opt/odoo/requirements.txt

# Çalışma dizinini ayarlıyoruz
WORKDIR /opt/odoo

# Ortam değişkenleri
ENV HOST 0.0.0.0
ENV PORT 8069

# Uygulama başlatma komutu
CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
