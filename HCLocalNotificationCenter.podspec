Pod::Spec.new do |spec|
  spec.name               = "HCLocalNotificationCenter"
  spec.version            = "1.0.2"
  spec.license            =  { :type => 'Private',
                               :text => <<-LICENSE
                                 Permission is hereby required to be explicitly and contractually granted
                                 by the original owner of this source, Neil Burchfield, to be used
                                 in any software, including that of usage, coping, modifying, merging,
                                 publishing, distributing, sublicensing, and/or selling copies of the Software,
                                 Those who are explicity granted and maintain a vaild license issued
                                 by the original owner must also subject to the following conditions:

                                 The above copyright notice and this permission notice shall be included in
                                 all copies or substantial portions of the Software.

                                 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
                                 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
                                 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
                                 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
                                 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
                                 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
                                 THE SOFTWARE.    
                              LICENSE
                        }
  spec.platform           = :ios
  spec.ios.deployment_target  = "7.0"
  spec.requires_arc       = true
  spec.ios.framework      = "UIKit"
  spec.source_files       = '*.{h,m}'
  spec.public_header_files    = '/*.h'
  spec.summary            = "Local Notification Handler"
  spec.author             = { "Neil Burchfield" => "neil.burchfield@gmail.com" }
end
