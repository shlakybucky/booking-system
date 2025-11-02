FROM node:20-alpine

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile --production=false

COPY . .

RUN chmod +x docker/entrypoint.sh

EXPOSE 3000
EXPOSE 5555

ENTRYPOINT ["sh", "docker/entrypoint.sh"]




# FROM node:20-alpine

# WORKDIR /usr/src/app

# COPY package.json yarn.lock ./

# RUN yarn install --frozen-lockfile

# COPY . .

# RUN chmod +x docker/entrypoint.sh

# EXPOSE 3000

# ENTRYPOINT ["sh", "docker/entrypoint.sh"]






# FROM node:20-alpine

# WORKDIR /usr/src/app

# COPY package.json yarn.lock ./

# RUN yarn install --frozen-lockfile
# RUN yarn global add @nestjs/cli

# COPY . .

# RUN chmod +x docker/entrypoint.sh

# RUN yarn prisma generate
# RUN yarn build

# EXPOSE 3000

# ENTRYPOINT ["sh", "docker/entrypoint.sh"]

# CMD ["yarn", "start:dev"]





# FROM node:20-alpine

# WORKDIR /usr/src/app

# COPY package*.json ./
# RUN npm install -g @nestjs/cli
# RUN npm install

# COPY . .

# RUN chmod +x docker/entrypoint.sh

# ENTRYPOINT ["sh", "docker/entrypoint.sh"]

# EXPOSE 3000




# FROM node:20-alpine

# WORKDIR /usr/src/app

# COPY package*.json ./
# RUN npm install

# COPY . .

# RUN npx prisma generate

# EXPOSE 3000
# CMD ["npm", "run", "start:dev"]



# --- Stage 1: Build ---
# FROM node:20-alpine AS builder

# WORKDIR /usr/src/app

# COPY package*.json ./
# RUN npm install --only=production

# COPY . .
# RUN npm run build

# # --- Stage 2: Run ---
# FROM node:20-alpine

# WORKDIR /usr/src/app

# COPY --from=builder /usr/src/app/node_modules ./node_modules
# COPY --from=builder /usr/src/app/dist ./dist
# COPY prisma ./prisma

# ENV NODE_ENV=production
# ENV PORT=3000

# EXPOSE 3000

# CMD ["node", "dist/main.js"]
