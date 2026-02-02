import jwt from "jsonwebtoken";

// Public routes that don't require authentication
const PUBLIC_ROUTES = ["/", "/api/register", "/api/login"];

export const globalMiddleware = (req, res, next) => {
  try {
    // Allow public routes without authentication
    if (PUBLIC_ROUTES.includes(req.path)) {
      return next();
    }

    // Check if Authorization header exists
    const authHeader = req.header("Authorization");
    if (!authHeader) {
      return res.status(401).json({
        error: "Authorization header required",
        message: "Please provide a valid authentication token",
        code: "NO_AUTH_HEADER",
      });
    }

    // Extract token from "Bearer <token>" format
    const parts = authHeader.split(" ");
    if (parts.length !== 2 || parts[0] !== "Bearer") {
      return res.status(401).json({
        error: "Invalid authorization format",
        message: "Format should be: Bearer <token>",
        code: "INVALID_AUTH_FORMAT",
      });
    }

    const token = parts[1];
    if (!token) {
      return res.status(401).json({
        error: "Token not provided",
        message: "Authentication token is missing",
        code: "NO_TOKEN",
      });
    }

    // Verify JWT token
    const JWT_SECRET = process.env.JWT_SECRET || "authlogin";
    const decoded = jwt.verify(token, JWT_SECRET);

    // Attach user info to request object
    req.user = decoded;

    // Continue to next middleware/route handler
    return next();
  } catch (err) {
    console.error("Authentication Middleware Error:", err.message);

    // Handle specific JWT errors
    if (err.name === "TokenExpiredError") {
      return res.status(401).json({
        error: "token expired",
        message: "Your session has expired. Please login again.",
        code: "TOKEN_EXPIRED",
      });
    }

    if (err.name === "JsonWebTokenError") {
      return res.status(401).json({
        error: "Invalid token",
        message: "The provided token is invalid or malformed.",
        code: "INVALID_TOKEN",
      });
    }

    if (err.name === "NotBeforeError") {
      return res.status(401).json({
        error: "Token not active",
        message: "This token is not yet valid.",
        code: "TOKEN_NOT_ACTIVE",
      });
    }

    // Generic error for unexpected issues
    return res.status(500).json({
      error: "Authentication failed",
      message: "An error occurred during authentication",
      code: "AUTH_ERROR",
    });
  }
};
