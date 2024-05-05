import { Prisma, PrismaClient } from '.prisma/client'

import { Pool } from "pg";
import { PrismaPg } from "@prisma/adapter-pg";

const connectionString = `${process.env.DATABASE_URL as string}`;

const pool = new Pool({ connectionString });
const adapter = new PrismaPg(pool);

const prisma = new PrismaClient({
    adapter,
    log: ["query"],
});

const id = "a0eeea10-7911-4af2-0000-01400b5718d2";
const intId = BigInt(1374511782084);

async function populate() {
    await prisma.user.create({
        data: {
            id,
            intId,
            name: "Christopher Addison",
        }
    });

    await prisma.baseUser.create({
        data: {
            id,
            intId,
        }
    });
}

type User = Prisma.BaseUserGetPayload<{ include: { user: true } }>

async function getUnsafe(id: string | bigint): Promise<User | null> {
    const query = {
        where: typeof id === "bigint" ? { intId: id } : { id },
        include: { user: true },
    };

    const result = await prisma.baseUser.findUnique(query);
    if (!result) {
        return null;
    }

    return result;
}

async function test() {
    const u = await getUnsafe(id);
    console.log(u);
}

async function main() {
    await populate();
    return test();
}

main()
    .catch((e) => console.error(e))
    .finally(async () => {
        prisma.$disconnect();
    });
