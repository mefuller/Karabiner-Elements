#pragma once

#include "logger.hpp"
#include <cstdint>
#include <ostream>
#include <pqrs/hash.hpp>
#include <pqrs/json.hpp>

namespace krbn {
class virtual_hid_devices_state final {
public:
  virtual_hid_devices_state(void)
      : virtual_hid_keyboard_ready_(false),
        virtual_hid_pointing_ready_(false) {
  }

  bool get_virtual_hid_keyboard_ready(void) const {
    return virtual_hid_keyboard_ready_;
  }

  void set_virtual_hid_keyboard_ready(bool value) {
    virtual_hid_keyboard_ready_ = value;
  }

  bool get_virtual_hid_pointing_ready(void) const {
    return virtual_hid_pointing_ready_;
  }

  void set_virtual_hid_pointing_ready(bool value) {
    virtual_hid_pointing_ready_ = value;
  }

private:
  bool virtual_hid_keyboard_ready_;
  bool virtual_hid_pointing_ready_;
};

inline void to_json(nlohmann::json& json, const virtual_hid_devices_state& s) {
  json["virtual_hid_keyboard_ready"] = s.get_virtual_hid_keyboard_ready();
  json["virtual_hid_pointing_ready"] = s.get_virtual_hid_pointing_ready();
}
} // namespace krbn

namespace std {
template <>
struct hash<krbn::virtual_hid_devices_state> final {
  std::size_t operator()(const krbn::virtual_hid_devices_state& value) const {
    std::size_t h = 0;

    pqrs::hash::combine(h, value.get_virtual_hid_keyboard_ready());
    pqrs::hash::combine(h, value.get_virtual_hid_pointing_ready());

    return h;
  }
};
} // namespace std
