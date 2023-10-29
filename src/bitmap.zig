const std = @import("std");

pub const Bitmap = struct {
  const Self = @This();

  allocator: std.mem.Allocator,
  width: u8,
  height: u8,
  pixels: []u1,

  // Create Bitmap
  pub fn create(allocator: std.mem.Allocator, width: u8,height: u8) !Self {
    var pixels = try allocator.alloc(u1, @as(u16, width) * @as(u16, height));
    @memset(pixels, 0);

    return Self {
      .allocator = allocator,
      .width = width,
      .height = height,
      .pixels = pixels,
    };
  }

  // Free Bitmap
  pub fn free(self: *Self) void {
    self.allocator.free(self.pixels);
  }

  // Clear Bitmap to specified value
  pub fn clear(self: *Self, value: u1) void {
    @memset(self.pixels, value);
  }

  // Set pixel value at x,y coordinate
  pub fn setPixel(self: *Self, x: u8,y: u8) bool {
    if(x >= self.width or y >= self.height) return false;

    var index: u16 = @as(u16, x) + @as(u16, y) * @as(u16, self.width);
    self.pixels[index] ^= 1;
    return (self.pixels[index] == 0);
  }

  // Get pixel value at x,y coordinate
  pub fn getPixel(self: *Self, x: u8,y: u8) u1 {
    if(x >= self.width or y >= self.height) return 0;

    var index: u16 = @as(u16, x) + @as(u16, y) * @as(u16, self.width);
    return self.pixels[index];
  }
};
