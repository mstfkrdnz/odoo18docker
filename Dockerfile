FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    git gcc python3-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libpq-dev curl npm node-less \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git /opt/odoo

RUN curl -o /opt/odoo/requirements.txt https://raw.githubusercontent.com/mstfkrdnz/odoo18docker/main/requirements.txt

# Debug: Requirements.txt içeriğini göster
RUN cat /opt/odoo/requirements.txt

# Güvenlik: Eski gevent varsa build'ı durdur
RUN grep "gevent==21.8.0" /opt/odoo/requirements.txt && (echo "HATALI REQUIREMENTS! Build durdu." && exit 1) || echo "Gevent doğru, devam."

RUN pip install --upgrade pip
RUN pip install "gevent>=22.10.2"
RUN pip install --no-cache-dir --ignore-installed gevent -r /opt/odoo/requirements.txt

WORKDIR /opt/odoo

ENV HOST 0.0.0.0
ENV PORT 8069

CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
