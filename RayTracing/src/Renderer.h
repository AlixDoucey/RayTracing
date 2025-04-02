#pragma once
#include "Walnut/Image.h"
#include "glm/fwd.hpp"
#include "glm/glm.hpp"
#include <memory>

class Renderer {
public:
  Renderer() = default;

  void OnResize(uint32_t width, uint32_t height);
  void Render();

  std::shared_ptr<Walnut::Image> GetFinalImage() const { return m_FinalImage; };

  glm::vec3 lightDir = glm::vec3(-1.0f, -1.0f, -1.0f);
  float colorArr[3]{1, 1, 1};
  bool showNormal;

private:
  glm::vec4 PerPixel(glm::vec2 rayDirection);
  std::shared_ptr<Walnut::Image> m_FinalImage;
  uint32_t *m_ImageData = nullptr;

  float m_LastRenderTime = 0.0f;
};
