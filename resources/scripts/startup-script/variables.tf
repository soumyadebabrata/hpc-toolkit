/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "deployment_name" {
  description = "Name of the HPC deployment, used to name GCS bucket for startup scripts."
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  type        = string
}

variable "runners" {
  description = "List of runners to run on remote VM"
  type = list(object({
    type = string,
    file = string,
  }))
  validation {
    condition = alltrue([
      for o in var.runners : contains(["ansible-local", "shell"], o.type)
    ])
    error_message = "Type can only be 'ansible-local' or 'shell'."
  }
  default = []
}