This is a mininal repro of an issue with `relationJoins` and `driverAdpaters` in Prisma when there is a BigInt relationship between two objects.

To run the repro:
```shell
npm install
npm start
```


The output is:
```shell
prisma:query INSERT INTO "public"."User" ("id","intId","name") VALUES ($1,$2,$3) RETURNING "public"."User"."id", "public"."User"."intId", "public"."User"."name"
prisma:query INSERT INTO "public"."BaseUser" ("id","intId") VALUES ($1,$2) RETURNING "public"."BaseUser"."id", "public"."BaseUser"."intId"
prisma:query SELECT "t1"."id", "t1"."intId", "BaseUser_user"."__prisma_data__" AS "user" FROM "public"."BaseUser" AS "t1" LEFT JOIN LATERAL (SELECT JSONB_BUILD_OBJECT('id', "t2"."id", 'intId', "t2"."intId", 'name', "t2"."name") AS "__prisma_data__" FROM "public"."User" AS "t2" WHERE "t1"."id" = "t2"."id" LIMIT $1) AS "BaseUser_user" ON true WHERE ("t1"."id" = $2 AND 1=1) LIMIT $3
PrismaClientKnownRequestError: 
Invalid `prisma.baseUser.findUnique()` invocation in
/Users/christophera/WebstormProjects/repro-prisma-issue/main.js:35:42

  32     where: typeof id === "bigint" ? { intId: id } : { id },
  33     include: { user: true },
  34 };
→ 35 const result = await prisma.baseUser.findUnique(
Inconsistent column data: Unexpected conversion failure for field User.intId from Number(1374511782084.0) to BigInt.
    at In.handleRequestError (/Users/christophera/WebstormProjects/repro-prisma-issue/node_modules/@prisma/client/runtime/library.js:122:6854)
    at In.handleAndLogRequestError (/Users/christophera/WebstormProjects/repro-prisma-issue/node_modules/@prisma/client/runtime/library.js:122:6188)
    at In.request (/Users/christophera/WebstormProjects/repro-prisma-issue/node_modules/@prisma/client/runtime/library.js:122:5896)
    at async l (/Users/christophera/WebstormProjects/repro-prisma-issue/node_modules/@prisma/client/runtime/library.js:127:11167)
    at async getUnsafe (/Users/christophera/WebstormProjects/repro-prisma-issue/main.js:35:20)
    at async test (/Users/christophera/WebstormProjects/repro-prisma-issue/main.js:42:15) {
  code: 'P2023',
  clientVersion: '5.13.0',
  meta: {
    modelName: 'BaseUser',
    message: 'Unexpected conversion failure for field User.intId from Number(1374511782084.0) to BigInt.'
  }
}
```
