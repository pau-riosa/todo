defmodule TodoWeb.Components.Navigation do
  use TodoWeb, :component

  def nav(assigns) do
    ~H"""
      <!-- This example requires Tailwind CSS v2.0+ -->
      <nav x-data="{ isOpen: false }" class="h-auto w-full bg-blue-900">
        <div class="max-w-7xl mx-auto px-2">
          <div class="relative flex items-center justify-between h-16">
            <div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
              <!-- Mobile menu button-->
                <button @click="isOpen = !isOpen "type="button" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white" aria-controls="mobile-menu" aria-expanded="false">
                  <span class="sr-only">Open main menu</span>
                  <i><%= Heroicons.icon("menu", type: "outline", class: "block h-6 w-6 mr-1 fill-indigo-500") %></i>
                  <i ><%= Heroicons.icon("x", type: "outline", class: "hidden h-7 w-7 mr-1 fill-indigo-500") %></i>
                </button>
              </div>
              <div class="flex-1 flex items-center justify-center sm:items-stretch sm:justify-start">
                <div class="flex-shrink-0 flex items-center">
                  <i><%= Heroicons.icon("check-circle", type: "outline", class: "h-7 w-7 mr-1 stroke-white") %></i>
                  <a href="/" class="text-2xl font-bold text-white">gawain</a>
                </div>
                <div class="hidden sm:block sm:ml-6">
                  <div class="flex space-x-4">
                    <!-- Current: "bg-gray-900 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
                    <%= live_patch "Dashboard",  to: Routes.live_path(@socket, TodoWeb.Instructor.DashboardLive ), class: "bg-yellow-900 text-blue-900 hover:bg-blue-900 hover:text-white px-3 py-2 rounded-md text-sm font-medium"  %>
                </div>
                  </div>
                </div>
                <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
                  <button type="button" class="bg-yellow-900 p-1 rounded-full text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-800 focus:ring-white">
                    <!-- Heroicon name: outline/bell -->
                      <i><%= Heroicons.icon("bell", type: "outline", class: "block h-6 w-6 stroke-blue-900") %></i>
                    </button>

                    <!-- Profile dropdown -->
                      <div class="ml-3 relative flex justify-end">
                        <div
                          x-data="{
                          open: false,
                          toggle() {
                          if (this.open) {
                          return this.close()
                          }

                          this.$refs.button.focus()

                          this.open = true
                          },
                          close(focusAfter) {
                          if (! this.open) return

                          this.open = false

                          focusAfter && focusAfter.focus()
                          }
                          }"
                          x-on:keydown.escape.prevent.stop="close($refs.button)"
                          x-on:focusin.window="! $refs.panel.contains($event.target) && close()"
                          x-id="['dropdown-button']"
                          class="relative"
                        >
                          <button 
                            x-ref="button"
                            x-on:click="toggle()"
                            :aria-expanded="open"
                            :aria-controls="$id('dropdown-button')"
                            type="button"
                            class="bg-gray-800 flex text-sm rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-800 focus:ring-white" id="user-menu-button" aria-expanded="false" aria-haspopup="true">
                            <span class="sr-only">Open user menu</span>
                            <img class="h-8 w-8 rounded-full" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="">
                          </button> 
                            <div
                              x-ref="panel"
                              x-show="open"
                              x-transition.origin.top.left
                              x-on:click.outside="close($refs.button)"
                              :id="$id('dropdown-button')"
                              style="display: none;"
                              class=" origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg py-1 bg-white ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="user-menu-button" tabindex="-1">
                <!-- Active: "bg-gray-100", Not Active: "" -->
                <p class="text-right block px-4 py-2 text-sm text-blue-900"><%= @current_user.email %></p>
                <div class="border-2  border-b-blue-900 mx-2"></div>
                <%= link "Settings", class: "text-right block px-4 py-2 text-sm text-blue-900", to: Routes.user_settings_path(@socket, :edit) %>
                <%= link "Log out", class: "text-right block px-4 py-2 text-sm text-blue-900", to: Routes.user_session_path(@socket, :delete), method: :delete %>
                </div>
                </div>
                </div>
                </div>
                </div>
                </div>

    <!-- Mobile menu, show/hide based on menu state. -->
    <div x-show="isOpen" @click.away="isOpen = false" class="sm:hidden" id="mobile-menu">
    <div class="px-2 pt-2 pb-3 space-y-1">
        <!-- Current: "bg-gray-900 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
        <a href="#" class="bg-gray-900 text-white block px-3 py-2 rounded-md text-base font-medium" aria-current="page">Dashboard</a>

        <a href="#" class="text-gray-300 hover:bg-gray-700 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Team</a>

        <a href="#" class="text-gray-300 hover:bg-gray-700 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Projects</a>

        <a href="#" class="text-gray-300 hover:bg-gray-700 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Calendar</a>
      </div>
    </div>
    </nav>
    """
  end
end
