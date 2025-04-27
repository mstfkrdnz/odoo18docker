FROM python:3.9-slim

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

RUN git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git /opt/odoo

WORKDIR /opt/odoo

RUN pip install -r odoo/requirements.txt

ENV HOST 0.0.0.0
ENV PORT 8069

CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
