// jwt.d.ts
import "jsonwebtoken";

declare module "jsonwebtoken" {
  export interface JwtPayload {
    id: string; // Add your custom id field
    iat?: number; // Optional standard claims
    exp?: number; // Optional standard claims
    nbf?: number; // Optional standard claims
  }
}