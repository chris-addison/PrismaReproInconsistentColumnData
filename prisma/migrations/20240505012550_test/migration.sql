-- CreateTable
CREATE TABLE "BaseUser" (
    "id" UUID NOT NULL,
    "intId" BIGINT NOT NULL,

    CONSTRAINT "BaseUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL,
    "intId" BIGINT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "BaseUser_intId_key" ON "BaseUser"("intId");

-- CreateIndex
CREATE INDEX "BaseUser_intId_idx" ON "BaseUser" USING BRIN ("intId" int8_bloom_ops);

-- CreateIndex
CREATE UNIQUE INDEX "User_intId_key" ON "User"("intId");

-- CreateIndex
CREATE INDEX "User_intId_idx" ON "User" USING BRIN ("intId" int8_bloom_ops);

-- AddForeignKey
ALTER TABLE "BaseUser" ADD CONSTRAINT "BaseUser_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BaseUser" ADD CONSTRAINT "BaseUser_intId_fkey" FOREIGN KEY ("intId") REFERENCES "User"("intId") ON DELETE RESTRICT ON UPDATE CASCADE;
