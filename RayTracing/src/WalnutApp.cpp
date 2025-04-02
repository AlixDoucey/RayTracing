#include "Walnut/Application.h"
#include "Walnut/EntryPoint.h"

#include "Renderer.h"
#include "Walnut/Image.h"
#include "Walnut/Timer.h"
#include "imgui.h"
#include <memory>

using namespace Walnut;

class MyLayer : public Walnut::Layer {
public:
  virtual void OnUIRender() override {
    ImGui::Begin("Settings");
    ImGui::Text("Last render: %.3fms", m_LastRenderTime);

    ImGui::Text("Light direction");
    ImGui::SliderFloat("x", &m_Renderer.lightDir.x, -1.0f, 1.0f);
    ImGui::SliderFloat("y", &m_Renderer.lightDir.y, -1.0f, 1.0f);
    ImGui::SliderFloat("z", &m_Renderer.lightDir.z, -1.0f, 1.0f);

    ImGui::Text("Sphere color");

    ImGui::ColorEdit3("<-- Color picker", m_Renderer.colorArr, 0);

    ImGui::Checkbox("Show normal map", &m_Renderer.showNormal);

    ImGui::End();

    ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0.0f, 0.0f));

    ImGui::Begin("Viewport");

    m_ViewportWidth = ImGui::GetContentRegionAvail().x;
    m_ViewportHeight = ImGui::GetContentRegionAvail().y;

    auto image = m_Renderer.GetFinalImage();

    if (image) {
      ImGui::Image(image->GetDescriptorSet(), {(float)image->GetWidth(), (float)image->GetHeight()}, ImVec2(0, 1),
                   ImVec2(1, 0));
    }

    ImGui::End();
    ImGui::PopStyleVar();

    Render();
  }

  void Render() {
    Timer timer;

    m_Renderer.OnResize(m_ViewportWidth, m_ViewportHeight);
    m_Renderer.Render();

    m_LastRenderTime = timer.ElapsedMillis();
  }

private:
  Renderer m_Renderer;
  uint32_t m_ViewportHeight = 0, m_ViewportWidth = 0;
  float m_LastRenderTime = 0;
};

Walnut::Application *Walnut::CreateApplication(int argc, char **argv) {
  Walnut::ApplicationSpecification spec;
  spec.Name = "Ray Tracing";

  Walnut::Application *app = new Walnut::Application(spec);
  app->PushLayer<MyLayer>();
  app->SetMenubarCallback([app]() {
    if (ImGui::BeginMenu("File")) {
      if (ImGui::MenuItem("Exit")) {
        app->Close();
      }
      ImGui::EndMenu();
    }
  });
  return app;
}
